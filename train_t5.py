import os
import argparse
import pickle

from tqdm import tqdm

import torch
import torch.nn as nn
import numpy as np
import wandb

from t5_utils import (
    initialize_model,
    initialize_optimizer_and_scheduler,
    save_model,
    load_model_from_checkpoint,
    setup_wandb,
)
from transformers import GenerationConfig
from load_data import load_t5_data, tokenizer
from utils import compute_metrics, save_queries_and_records

DEVICE = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")
PAD_IDX = 0


def get_args():
    """
    Arguments for training. You may choose to change or extend these as you see fit.
    """
    parser = argparse.ArgumentParser(description="T5 training loop")

    # Model hyperparameters
    parser.add_argument(
        "--finetune", action="store_true", help="Whether to finetune T5 or not"
    )

    # Training hyperparameters
    parser.add_argument(
        "--optimizer_type",
        type=str,
        default="AdamW",
        choices=["AdamW"],
        help="What optimizer to use",
    )
    parser.add_argument("--learning_rate", type=float, default=0.001)
    parser.add_argument("--weight_decay", type=float, default=0.01)
    parser.add_argument("--label_smoothing", type=float, default=0.1)

    parser.add_argument(
        "--scheduler_type",
        type=str,
        default="cosine",
        choices=["none", "cosine", "linear"],
        help="Whether to use a LR scheduler and what type to use if so",
    )
    parser.add_argument(
        "--num_warmup_epochs",
        type=int,
        default=1,
        help="How many epochs to warm up the learning rate for if using a scheduler",
    )
    parser.add_argument(
        "--max_n_epochs",
        type=int,
        default=1,
        help="How many epochs to train the model for",
    )
    parser.add_argument(
        "--patience_epochs",
        type=int,
        default=3,
        help="If validation performance stops improving, how many epochs should we wait before stopping?",
    )

    parser.add_argument(
        "--use_wandb",
        action="store_true",
        help="If set, we will use wandb to keep track of experiments",
    )
    parser.add_argument(
        "--experiment_name",
        type=str,
        default="experiment",
        help="How should we name this experiment?",
    )

    # Data hyperparameters
    parser.add_argument("--batch_size", type=int, default=16)
    parser.add_argument("--test_batch_size", type=int, default=1)

    args = parser.parse_args()
    return args


def train(args, model, train_loader, dev_loader, optimizer, scheduler):
    best_f1 = -1
    epochs_since_improvement = 0
    experiment_name = args.experiment_name
    model_type = "ft" if args.finetune else "scr"
    checkpoint_dir = os.path.join(
        "checkpoints", f"{model_type}_experiments", args.experiment_name
    )
    gt_sql_path = os.path.join(f"data/dev.sql")
    gt_record_path = os.path.join(f"records/ground_truth_dev.pkl")
    model_sql_path = os.path.join(f"results/t5_{model_type}_{experiment_name}_dev.sql")
    model_record_path = os.path.join(
        f"records/t5_{model_type}_{experiment_name}_dev.pkl"
    )
    print(f"{model_type} experiment {experiment_name} starting")
    print(f"args: {args}")
    if args.max_n_epochs == 0:
        save_model(checkpoint_dir, model, best=True)
        return
    for epoch in range(args.max_n_epochs):
        print(f"Epoch {epoch}: Training")
        tr_loss = train_epoch(args, model, train_loader, optimizer, scheduler)
        print(f"Epoch {epoch}: Average train loss was {tr_loss}")

        eval_loss, record_f1, record_em, sql_em, error_rate = eval_epoch(
            args,
            model,
            dev_loader,
            gt_sql_path,
            model_sql_path,
            gt_record_path,
            model_record_path,
        )
        print(
            f"Epoch {epoch}: Dev loss: {eval_loss}, Record F1: {record_f1}, Record EM: {record_em}, SQL EM: {sql_em}"
        )
        print(
            f"Epoch {epoch}: {error_rate * 100:.2f}% of the generated outputs led to SQL errors"
        )

        if args.use_wandb:
            result_dict = {
                "train/loss": tr_loss,
                "dev/loss": eval_loss,
                "dev/record_f1": record_f1,
                "dev/record_em": record_em,
                "dev/sql_em": sql_em,
                "dev/error_rate": error_rate,
            }
            wandb.log(result_dict, step=epoch)

        if record_f1 > best_f1:
            best_f1 = record_f1
            epochs_since_improvement = 0
        else:
            epochs_since_improvement += 1

        save_model(checkpoint_dir, model, best=False)
        if epochs_since_improvement == 0:
            save_model(checkpoint_dir, model, best=True)

        if epochs_since_improvement >= args.patience_epochs:
            break


def train_epoch(args, model, train_loader, optimizer, scheduler) -> float:
    model.train()
    total_loss = 0
    total_tokens = 0
    criterion = nn.CrossEntropyLoss(label_smoothing=args.label_smoothing)

    for encoder_input, encoder_mask, decoder_input, decoder_targets, _ in tqdm(
        train_loader
    ):
        optimizer.zero_grad()
        encoder_input = encoder_input.to(DEVICE)
        encoder_mask = encoder_mask.to(DEVICE)
        decoder_input = decoder_input.to(DEVICE)
        decoder_targets = decoder_targets.to(DEVICE)

        # Forward pass
        output = model(encoder_input, encoder_mask, decoder_input)
        logits = output.logits  # Access logits from the model's output

        # Compute loss
        loss = criterion(logits.view(-1, logits.size(-1)), decoder_targets.view(-1))
        loss.backward()  # Perform backpropagation

        # Update model parameters
        optimizer.step()
        scheduler.step()  # Update learning rate

        # Accumulate loss and calculate tokens for averaging
        total_loss += loss.item() * decoder_targets.numel()
        total_tokens += decoder_targets.numel()

    # Compute average loss over all tokens
    average_loss = total_loss / total_tokens

    return average_loss


def eval_epoch(
    args,
    model,
    dev_loader,
    gt_sql_pth,
    model_sql_path,
    gt_record_path,
    model_record_path,
):
    """
    You must implement the evaluation loop to be using during training. We recommend keeping track
    of the model loss on the SQL queries, the metrics compute_metrics returns (save_queries_and_records should be helpful)
    and the model's syntax error rate.

    To compute non-loss metrics, you will need to perform generation with the model. Greedy decoding or beam search
    should both provide good results. If you find that this component of evaluation takes too long with your compute,
    we found the cross-entropy loss (in the evaluation set) to be well (albeit imperfectly) correlated with F1 performance.
    """
    # TODO
    model.eval()
    total_loss = 0
    total_tokens = 0
    all_generated_sql = []
    criterion = torch.nn.CrossEntropyLoss()

    with torch.no_grad():
        for batch in tqdm(dev_loader):
            input_ids, encoder_mask, decoder_inputs, labels, initial_decoder_inputs = (
                item.to(DEVICE) for item in batch
            )
            input_ids = input_ids.to(DEVICE)
            encoder_mask = encoder_mask.to(DEVICE)
            labels = labels.to(DEVICE)
            model = model.to(DEVICE)

            outputs = model(
                input_ids=input_ids, attention_mask=encoder_mask, labels=labels
            )
            loss = criterion(
                outputs.logits.transpose(1, 2), labels
            )  # Adjust dimensions for CrossEntropyLoss
            total_loss += loss.item()

            # Generation and decoding

            predicted_sql = model.generate(input_ids)
            generated_sql = [
                tokenizer.decode(
                    g, skip_special_tokens=True, clean_up_tokenization_spaces=True
                )
                for g in predicted_sql
            ]
            print(f"Input: {tokenizer.decode(input_ids, skip_special_tokens=True)}\n"
                  f"Generated SQL: {generated_sql}\n")
            # print(generated_sql)
            all_generated_sql.extend(generated_sql)

    # Compute average loss
    avg_loss = total_loss / len(dev_loader.dataset)
    # Save and compute metrics
    save_queries_and_records(all_generated_sql, model_sql_path, model_record_path)

    print(
        f"gt_sql_pth: {gt_sql_pth}\n"
        f"model_sql_path: {model_sql_path}\n"
        f"gt_record_path: {gt_record_path}\n"
        f"model_record_path: {model_record_path}\n"
    )

    record_f1, record_em, sql_em, error_message = compute_metrics(
        gt_sql_pth, model_sql_path, gt_record_path, model_record_path
    )
    syntax_error_rate = len(error_message) / len(all_generated_sql)
    return avg_loss, record_f1, record_em, sql_em, syntax_error_rate


def test_inference(args, model, test_loader, model_sql_path, model_record_path):
    """
    You must implement inference to compute your model's generated SQL queries and its associated
    database records. Implementation should be very similar to eval_epoch.
    """
    model.eval()
    generated_sql_queries = []
    generated_records = []

    for batch in tqdm(test_loader):
        encoder_input, encoder_mask, initial_decoder_input = batch

        # Move tensors to the appropriate device
        encoder_input = encoder_input.to(DEVICE)
        encoder_mask = encoder_mask.to(DEVICE)
        initial_decoder_input = initial_decoder_input.to(DEVICE)

        # Generate output using the model
        # Here we use greedy decoding for simplicity, you can switch to beam search if needed
        outputs = model.generate(
            input_ids=encoder_input,
            attention_mask=encoder_mask,
            decoder_start_token_id=model.config.decoder_start_token_id,
        )

        # Convert token IDs to strings
        output_queries = [
            tokenizer.decode(ids, skip_special_tokens=True) for ids in outputs
        ]
        generated_sql_queries.extend(output_queries)

        # Placeholder for generating records from SQL (you'll need actual database interaction here)
        records = ["record_placeholder" for _ in outputs]
        generated_records.extend(records)

    # Saving generated SQL queries and records to files
    with open(model_sql_path, "w", encoding="utf8") as f:
        for query in generated_sql_queries:
            f.write(query + "\n")

    with open(model_record_path, "wb") as f:
        pickle.dump(generated_records, f)

    print(f"Generated SQL queries saved to {model_sql_path}")
    print(f"Associated records saved to {model_record_path}")


def main():
    # Get key arguments
    args = get_args()
    if args.use_wandb:
        # Recommended: Using wandb (or tensorboard) for result logging can make experimentation easier
        setup_wandb(args)

    # Load the data and the model
    train_loader, dev_loader, test_loader = load_t5_data(
        args.batch_size, args.test_batch_size
    )
    model = initialize_model(args).to(DEVICE)

    optimizer, scheduler = initialize_optimizer_and_scheduler(
        args, model, len(train_loader)
    )

    # Train
    train(args, model, train_loader, dev_loader, optimizer, scheduler)

    # Evaluate
    model = load_model_from_checkpoint(args, best=True)
    model.eval()

    # Dev set
    experiment_name = args.experiment_name
    model_type = "ft" if args.finetune else "scr"
    gt_sql_path = os.path.join(f"data/dev.sql")
    gt_record_path = os.path.join(f"records/ground_truth_dev.pkl")
    model_sql_path = os.path.join(f"results/t5_{model_type}_{experiment_name}_dev.sql")
    model_record_path = os.path.join(
        f"records/t5_{model_type}_{experiment_name}_dev.pkl"
    )
    dev_loss, dev_record_em, dev_record_f1, dev_sql_em, dev_error_rate = eval_epoch(
        args,
        model,
        dev_loader,
        gt_sql_path,
        model_sql_path,
        gt_record_path,
        model_record_path,
    )
    print(
        f"Dev set results: Loss: {dev_loss}, Record F1: {dev_record_f1}, Record EM: {dev_record_em}, SQL EM: {dev_sql_em}"
    )
    # print(
    #     f"Dev set results: {dev_error_rate * 100:.2f}% of the generated outputs led to SQL errors"
    # )
    print(
        f"Dev set results: {dev_error_rate * 100}% of the generated outputs led to SQL errors"
    )

    # Test set
    model_sql_path = os.path.join(f"results/t5_{model_type}_{experiment_name}_test.sql")
    model_record_path = os.path.join(
        f"records/t5_{model_type}_{experiment_name}_test.pkl"
    )
    test_inference(args, model, test_loader, model_sql_path, model_record_path)


if __name__ == "__main__":
    main()
