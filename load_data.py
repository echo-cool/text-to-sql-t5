import os, random, re, string
from collections import Counter
from tqdm import tqdm
import pickle

from torch.utils.data import Dataset, DataLoader
from torch.nn.utils.rnn import pad_sequence

import nltk

from prompting_utils import read_schema

nltk.download("punkt")
from transformers import T5TokenizerFast
import torch

tokenizer = T5TokenizerFast.from_pretrained("google-t5/t5-small")
PAD_IDX = tokenizer.pad_token_id
# print(tokenizer.pad_token_id)
DECODER_BEGIN_TOKEN_ID = 32099


class T5Dataset(Dataset):
    def __init__(self, data_folder, split):
        """
        Skeleton for the class for performing data processing for the T5 model.

        Some tips for implementation:
            * You should be using the 'google-t5/t5-small' tokenizer checkpoint to tokenize both
              the encoder and decoder output.
            * You want to provide the decoder some beginning of sentence token. Any extra-id on the
              T5Tokenizer should serve that purpose.
            * Class behavior should be different on the test set.
        """
        # TODO
        self.data_folder = data_folder
        self.split = split
        self.texts, self.sql_commands = self.process_data(data_folder, split, tokenizer)

    def process_data(self, data_folder, split, tokenizer):
        text_file = os.path.join(data_folder, f"{split}.nl")
        schema = read_schema(os.path.join(data_folder, "flight_database.schema"))
        texts = load_lines(text_file)
        prompts = []
        for text in texts:
            question = text
            # prompt = f"""Translate English to SQL
            # Tables:
            # {schema}
            # Question:
            # {question}
            # Answer:
            # """
            prompt = f"{question}"
            prompts.append(prompt)

        tokenized_texts = [tokenizer(text, return_tensors="pt") for text in prompts]
        if split == "test":
            return tokenized_texts, None

        sql_file = os.path.join(data_folder, f"{split}.sql")
        sql_queries = load_lines(sql_file)
        tokenized_sql = []
        for sql in sql_queries:
            sql = sql.replace("\n", "")
            # sql_token = tokenizer(sql, return_tensors="pt")
            sql_token_with_bos = tokenizer(f"<extra_id_0>{sql}", return_tensors="pt")

            tokenized_sql.append(sql_token_with_bos)
        return tokenized_texts, tokenized_sql

    def __len__(self):
        return len(self.texts)

    def __getitem__(self, idx):
        item = {
            "input_ids": self.texts[idx]["input_ids"].flatten(),
            "attention_mask": self.texts[idx]["attention_mask"].flatten(),
        }
        if self.sql_commands is not None:
            item["labels"] = self.sql_commands[idx]["input_ids"].flatten()
            item["decoder_attention_mask"] = self.sql_commands[idx][
                "attention_mask"
            ].flatten()
        return item


def normal_collate_fn(batch):
    """
    Collation function to perform dynamic padding for training and evaluation with the
    development or validation set.

    Inputs:
        * batch (List[Any]): batch is a list of length batch_size, where each index contains what
                             the dataset __getitem__ function returns.

    Returns: To be compatible with the provided training loop, you should be returning
        * encoder_ids: The input ids of shape BxT to be fed into the T5 encoder.
        * encoder_mask: Mask of shape BxT associated with padding tokens in the encoder input
        * decoder_inputs: Decoder input ids of shape BxT' to be fed into T5 decoder.
        * decoder_targets: The target tokens with which to train the decoder (the tokens following each decoder input)
        * initial_decoder_inputs: The very first input token to be decoder (only to be used in evaluation)
    """
    # TODO

    input_ids = [item["input_ids"] for item in batch]
    labels = [item["labels"] for item in batch]

    input_ids_padded = pad_sequence(input_ids, batch_first=True, padding_value=PAD_IDX)
    labels_padded = pad_sequence(labels, batch_first=True, padding_value=PAD_IDX)

    encoder_mask = (input_ids_padded != PAD_IDX).type(torch.long)

    # Prepare decoder inputs by prepending with eos_token_id and removing the last token
    decoder_inputs = [
        torch.cat([torch.tensor([DECODER_BEGIN_TOKEN_ID]), lbl[:-1]]) for lbl in labels
    ]
    decoder_inputs_padded = pad_sequence(
        decoder_inputs, batch_first=True, padding_value=PAD_IDX
    )

    initial_decoder_inputs = torch.full((len(batch), 1), DECODER_BEGIN_TOKEN_ID).type(
        torch.long
    )

    return (
        input_ids_padded,
        encoder_mask,
        decoder_inputs_padded,
        labels_padded,
        initial_decoder_inputs,
    )


def test_collate_fn(batch):
    """
    Collation function to perform dynamic padding for inference on the test set.

    Inputs:
        * batch (List[Any]): batch is a list of length batch_size, where each index contains what
                             the dataset __getitem__ function returns.

    Recommended returns:
        * encoder_ids: The input ids of shape BxT to be fed into the T5 encoder.
        * encoder_mask: Mask of shape BxT associated with padding tokens in the encoder input
        * initial_decoder_inputs: The very first input token to be decoder (only to be used in evaluation)
    """
    # TODO
    input_ids = [item["input_ids"] for item in batch]
    input_ids_padded = pad_sequence(input_ids, batch_first=True, padding_value=PAD_IDX)
    encoder_mask = (input_ids_padded != PAD_IDX).type(torch.long)

    initial_decoder_inputs = torch.full((len(batch), 1), DECODER_BEGIN_TOKEN_ID).type(
        torch.long
    )

    return input_ids_padded, encoder_mask, initial_decoder_inputs


def get_dataloader(batch_size, split):
    data_folder = "data"
    dset = T5Dataset(data_folder, split)
    shuffle = split == "train"
    collate_fn = normal_collate_fn if split != "test" else test_collate_fn

    dataloader = DataLoader(
        dset, batch_size=batch_size, shuffle=shuffle, collate_fn=collate_fn
    )
    return dataloader


def load_t5_data(batch_size, test_batch_size):
    train_loader = get_dataloader(batch_size, "train")
    dev_loader = get_dataloader(test_batch_size, "dev")
    test_loader = get_dataloader(test_batch_size, "test")

    return train_loader, dev_loader, test_loader


def load_lines(path):
    with open(path, "r") as f:
        lines = f.readlines()
        lines = [line.strip() for line in lines]
    return lines


def process_data(data_folder, split, tokenizer):
    text_file = os.path.join(data_folder, f"{split}.nl")
    texts = load_lines(text_file)

    tokenized_texts = [text for text in texts]
    if split == "test":
        return tokenized_texts, None

    sql_file = os.path.join(data_folder, f"{split}.sql")
    sql_queries = load_lines(sql_file)
    tokenized_sql = [sql for sql in sql_queries]

    return tokenized_texts, tokenized_sql


def load_prompting_data(data_folder):
    train_x, train_y = process_data(data_folder, "train", tokenizer)
    dev_x, dev_y = process_data(data_folder, "dev", tokenizer)
    test_x, test_y = process_data(data_folder, "test", tokenizer)
    return train_x, train_y, dev_x, dev_y, test_x, test_y
