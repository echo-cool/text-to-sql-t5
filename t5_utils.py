import os

import torch

import transformers
from transformers import T5ForConditionalGeneration, T5Config
from transformers.pytorch_utils import ALL_LAYERNORM_LAYERS
import wandb

DEVICE = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")

import wandb


def setup_wandb(args):
    """
    Initialize wandb for experiment tracking.

    Args:
        args (dict): Contains configuration for wandb, including project name, entity, and other settings.
    """
    wandb.login(key="c23edd97e88391a7c39b05c285e644a0bc72ef34")
    wandb.init(
        project="t5-sql-translation",
        entity="yuyang-wang821",
        config=args,
    )
    print("wandb setup complete with project:", "t5-sql-translation")


def initialize_model(args):
    """
    Helper function to initialize the model. You should be either finetuning
    the pretrained model associated with the 'google-t5/t5-small' checkpoint
    or training a T5 model initialized with the 'google-t5/t5-small' config
    from scratch.
    """
    if args.finetune:
        # Load a pretrained model
        model = T5ForConditionalGeneration.from_pretrained(
            "google-t5/t5-small", torch_dtype=torch.bfloat16
        )
        print("Loaded pretrained T5 model.")
    else:
        # Initialize a model with T5 configuration from scratch
        config = T5Config.from_pretrained(
            "google-t5/t5-small", torch_dtype=torch.bfloat16
        )
        model = T5ForConditionalGeneration(config)
        print("Initialized T5 model from scratch with T5 small configuration.")

    return model


def mkdir(dirpath):
    if not os.path.exists(dirpath):
        try:
            os.makedirs(dirpath)
        except FileExistsError:
            pass


def save_model(checkpoint_dir, model, best=False):
    """
    Saves the current model state as a checkpoint.

    Args:
        checkpoint_dir (str): Directory where the checkpoint will be saved.
        model (torch.nn.Module): The model instance to be saved.
        best (bool): A flag indicating whether this checkpoint is the best performing model.
    """
    if not os.path.exists(checkpoint_dir):
        os.makedirs(checkpoint_dir)

    filename = "best_model.pth" if best else "checkpoint.pth"
    checkpoint_path = os.path.join(checkpoint_dir, filename)

    torch.save(model.state_dict(), checkpoint_path)
    print(f"Model saved to {checkpoint_path}")


def load_model_from_checkpoint(args, best=False):
    """
    Load a T5 model from a specified checkpoint.

    Args:
        args (dict): Configuration for model loading. Should include 'checkpoint_dir'.
        best (bool): A flag to load the best performing model checkpoint.
    """
    # Construct the checkpoint directory based on the experiment name
    model_type = "ft" if args.finetune else "scr"
    checkpoint_dir = os.path.join(
        "checkpoints", f"{model_type}_experiments", args.experiment_name
    )
    filename = "best_model.pth" if best else "checkpoint.pth"
    checkpoint_path = os.path.join(checkpoint_dir, filename)

    # Check if the file exists
    if not os.path.exists(checkpoint_path):
        raise FileNotFoundError(f"No checkpoint found at {checkpoint_path}")

    # Load the model configuration from the specified T5 variant
    config = T5Config.from_pretrained("google-t5/t5-small")
    model = T5ForConditionalGeneration(config)
    model.load_state_dict(torch.load(checkpoint_path))
    print(f"Model loaded from {checkpoint_path}")

    return model


def initialize_optimizer_and_scheduler(args, model, epoch_length):
    optimizer = initialize_optimizer(args, model)
    scheduler = initialize_scheduler(args, optimizer, epoch_length)
    return optimizer, scheduler


def initialize_optimizer(args, model):
    decay_parameters = get_parameter_names(model, ALL_LAYERNORM_LAYERS)
    decay_parameters = [name for name in decay_parameters if "bias" not in name]
    optimizer_grouped_parameters = [
        {
            "params": [
                p
                for n, p in model.named_parameters()
                if (n in decay_parameters and p.requires_grad)
            ],
            "weight_decay": args.weight_decay,
        },
        {
            "params": [
                p
                for n, p in model.named_parameters()
                if (n not in decay_parameters and p.requires_grad)
            ],
            "weight_decay": 0.0,
        },
    ]

    if args.optimizer_type == "AdamW":
        optimizer = torch.optim.AdamW(
            optimizer_grouped_parameters,
            lr=args.learning_rate,
            eps=1e-8,
            betas=(0.9, 0.999),
        )
    else:
        pass

    return optimizer


def initialize_scheduler(args, optimizer, epoch_length):
    num_training_steps = epoch_length * args.max_n_epochs
    num_warmup_steps = epoch_length * args.num_warmup_epochs

    if args.scheduler_type == "none":
        return None
    elif args.scheduler_type == "cosine":
        return transformers.get_cosine_schedule_with_warmup(
            optimizer, num_warmup_steps, num_training_steps
        )
    elif args.scheduler_type == "linear":
        return transformers.get_linear_schedule_with_warmup(
            optimizer, num_warmup_steps, num_training_steps
        )
    elif args.scheduler_type == "cosine_with_restarts":
        return transformers.get_cosine_with_hard_restarts_schedule_with_warmup(
            optimizer, num_warmup_steps, num_training_steps
        )
    else:
        raise NotImplementedError


def get_parameter_names(model, forbidden_layer_types):
    result = []
    for name, child in model.named_children():
        result += [
            f"{name}.{n}"
            for n in get_parameter_names(child, forbidden_layer_types)
            if not isinstance(child, tuple(forbidden_layer_types))
        ]
    # Add model specific parameters (defined with nn.Parameter) since they are not in any child.
    result += list(model._parameters.keys())
    return result
