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
    parser.add_argument("--learning_rate", type=float, default=0.005)
    parser.add_argument("--weight_decay", type=float, default=0.01)
    parser.add_argument("--label_smoothing", type=float, default=0.1)

    parser.add_argument(
        "--scheduler_type",
        type=str,
        default="cosine",
        choices=["none", "cosine", "linear", "cosine_with_restarts"],
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
        default=10,
        help="How many epochs to train the model for",
    )
    parser.add_argument(
        "--patience_epochs",
        type=int,
        default=5,
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

    parser.add_argument(
        "--skip_train_eval",
        action="store_true",
        help="If set, we will skip training and evaluation and only do inference",
    )

    # Data hyperparameters
    parser.add_argument("--batch_size", type=int, default=16)
    parser.add_argument("--test_batch_size", type=int, default=16)

    args = parser.parse_args()
    return args


def train(args, model, train_loader, dev_loader, optimizer, scheduler):
    best_f1 = -1
    best_train_loss = np.inf
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

    if os.path.exists("logs"):
        pass
    else:
        os.makedirs("logs")

    log_path = "logs/log-t5.txt"
    with open(log_path, "w") as f:
        f.write(f"Starting {model_type} experiment {experiment_name}\n")
        # f.write(f"args: {args}\n")
        for arg in vars(args):
            f.write(f"{arg}: {getattr(args, arg)}\n")

    for epoch in range(args.max_n_epochs):
        print(f"Epoch {epoch}: Training")
        tr_loss = train_epoch(args, model, train_loader, optimizer, scheduler)
        print(f"Epoch {epoch}: Average train loss was {tr_loss}")
        if args.skip_train_eval:
            save_model(checkpoint_dir, model, best=False)
            if tr_loss < best_train_loss:
                best_train_loss = tr_loss
                save_model(checkpoint_dir, model, best=True)
            else:
                epochs_since_improvement += 1
            if epochs_since_improvement >= args.patience_epochs:
                break
            continue
        eval_loss, record_f1, record_em, sql_em, error_rate, error_message = eval_epoch(
            args,
            epoch,
            model,
            dev_loader,
            gt_sql_path,
            model_sql_path,
            gt_record_path,
            model_record_path,
        )
        # save to log
        if os.path.exists("logs"):
            log_path = "logs/log-t5.txt"
            with open(log_path, "a") as f:
                f.write(f"Epoch {epoch}: train_loss: {tr_loss}\n")
                f.write(
                    f"Epoch {epoch}: eval_loss: {eval_loss}, Record F1: {record_f1}, Record EM: {record_em}, SQL EM: {sql_em}\n"
                )
                f.write(
                    f"Epoch {epoch}: {error_rate * 100:.2f}% of the generated outputs led to SQL errors\n"
                )
                f.write(f"Epoch {epoch}: {error_message}\n")

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


def train_epoch(args, model, train_loader, optimizer, scheduler):
    model.train()
    total_loss = 0
    total_tokens = 0
    criterion = nn.CrossEntropyLoss(label_smoothing=args.label_smoothing)

    for (
        encoder_input,
        encoder_mask,
        decoder_input,
        decoder_targets,
        initial_decoder_inputs,
    ) in tqdm(train_loader):
        optimizer.zero_grad()
        encoder_input = encoder_input.to(DEVICE)
        encoder_mask = encoder_mask.to(DEVICE)
        decoder_input = decoder_input.to(DEVICE)
        decoder_targets = decoder_targets.to(DEVICE)

        output = model(
            input_ids=encoder_input,
            attention_mask=encoder_mask,
            # decoder_input_ids=decoder_input,
            labels=decoder_targets,
        )

        logits = output["logits"]

        non_pad = decoder_targets != PAD_IDX
        loss = output.loss

        loss.backward()
        optimizer.step()
        if scheduler is not None:
            scheduler.step()

        with torch.no_grad():
            num_tokens = torch.sum(non_pad).item()
            total_loss += loss.item() * num_tokens
            total_tokens += num_tokens

    return total_loss / total_tokens


def eval_epoch(
    args,
    epoch_number,
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
    if epoch_number is None:
        epoch_number = "eval"
    model.eval()
    total_loss = 0
    total_tokens = 0
    all_generated_sql = []
    # criterion = nn.CrossEntropyLoss(ignore_index=tokenizer.pad_token_id)
    if not os.path.exists("logs/sql"):
        os.makedirs("logs/sql")

    with open(f"logs/sql/epoch_sql_{epoch_number}.txt", "w") as f:
        f.write(f"Epoch {epoch_number}\n")

    with torch.no_grad():
        for batch in tqdm(dev_loader):
            input_ids, encoder_mask, decoder_inputs, labels, initial_decoder_inputs = (
                item.to(DEVICE) for item in batch
            )
            input_ids = input_ids.to(DEVICE)
            encoder_mask = encoder_mask.to(DEVICE)
            labels = labels.to(DEVICE)
            model = model.to(DEVICE)
            output = model(
                input_ids=input_ids,
                attention_mask=encoder_mask,
                # decoder_input_ids=decoder_inputs,
                labels=labels,
            )

            logits = output["logits"]

            non_pad = labels != PAD_IDX
            loss = output.loss

            with torch.no_grad():
                num_tokens = torch.sum(non_pad).item()
                total_loss += loss.item() * num_tokens
                total_tokens += num_tokens

            # Generation and decoding

            predicted_sql = model.generate(
                input_ids,
                attention_mask=encoder_mask,
                max_length=512,
                num_beams=4,
            )
            generated_sql = [
                tokenizer.decode(g, skip_special_tokens=True) for g in predicted_sql
            ]
            with open(
                f"logs/sql/epoch_sql_{epoch_number}.txt", "a", encoding="utf8"
            ) as f:
                for sql_command in generated_sql:
                    # print(sql_command)
                    f.write(sql_command + "\n")

            all_generated_sql.extend(generated_sql)

    # Compute average loss
    avg_loss = total_loss / num_tokens
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
    syntax_error_rate = sum([1 for m in error_message if m != ""]) / len(error_message)
    return avg_loss, record_f1, record_em, sql_em, syntax_error_rate, error_message


def test_inference(args, model, test_loader, model_sql_path, model_record_path):
    """
    You must implement inference to compute your model's generated SQL queries and its associated
    database records. Implementation should be very similar to eval_epoch.
    """
    model.eval()  # Set the model to evaluation mode
    all_generated_sql = []

    if not os.path.exists("logs/sql"):
        os.makedirs("logs/sql")

    # File to store generated SQL queries
    with open(f"logs/sql/inference_sql.txt", "w") as f:
        f.write("Inference Results\n")

    with torch.no_grad():
        for batch in tqdm(test_loader):
            input_ids, encoder_mask, initial_decoder_inputs = (
                item.to(DEVICE) for item in batch
            )
            # Generate SQL queries
            predicted_sql = model.generate(
                input_ids,
                attention_mask=encoder_mask,
                max_length=512,
                num_beams=4,

            )
            generated_sql = [
                tokenizer.decode(g, skip_special_tokens=True) for g in predicted_sql
            ]
            with open("logs/sql/inference_sql.txt", "a", encoding="utf8") as f:
                for sql_command in generated_sql:
                    # print(sql_command)
                    f.write(sql_command + "\n")

            all_generated_sql.extend(generated_sql)

    # Save the generated queries and records
    save_queries_and_records(all_generated_sql, model_sql_path, model_record_path)
    print(f"model_sql_path: {model_sql_path}\nmodel_record_path: {model_record_path}\n")
    print("Inference completed and results saved.")


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
    (
        dev_loss,
        dev_record_em,
        dev_record_f1,
        dev_sql_em,
        dev_error_rate,
        error_message,
    ) = eval_epoch(
        args,
        None,
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
    model_sql_path = os.path.join(f"results/t5_{model_type}_test.sql")
    model_record_path = os.path.join(f"records/t5_{model_type}_test.pkl")
    test_inference(args, model, test_loader, model_sql_path, model_record_path)


if __name__ == "__main__":
    main()
