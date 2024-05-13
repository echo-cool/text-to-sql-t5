import numpy as np

train_nl_examples = []
with open("data/train.nl") as f:
    for line in f:
        train_nl_examples.append(line.strip())

train_sql_examples = []
with open("data/train.sql") as f:
    for line in f:
        train_sql_examples.append(line.strip())

dev_nl_examples = []
with open("data/dev.nl") as f:
    for line in f:
        dev_nl_examples.append(line.strip())

dev_sql_examples = []
with open("data/dev.sql") as f:
    for line in f:
        dev_sql_examples.append(line.strip())

#Number of examples & \textcolor{gray}{XXX} & \textcolor{gray}{XXX} \\
# Mean sentence length & \textcolor{gray}{XXX}& \textcolor{gray}{XXX} \\
# Mean SQL query length & \textcolor{gray}{XXX}& \textcolor{gray}{XXX}  \\
# Vocabulary size (natural language)& \textcolor{gray}{XXX}& \textcolor{gray}{XXX}  \\
# Vocabulary size (SQL)& \textcolor{gray}{XXX}& \textcolor{gray}{XXX}  \\

# get Statistics
train_nl_len = [len(x.split()) for x in train_nl_examples]
train_sql_len = [len(x.split()) for x in train_sql_examples]
dev_nl_len = [len(x.split()) for x in dev_nl_examples]
dev_sql_len = [len(x.split()) for x in dev_sql_examples]

print("Number of examples & {} & {} \\\\".format(len(train_nl_examples), len(dev_nl_examples)))
print("Mean sentence length & {}& {} \\\\".format(np.mean(train_nl_len), np.mean(dev_nl_len)))
print("Mean SQL query length & {}& {} \\\\".format(np.mean(train_sql_len), np.mean(dev_sql_len)))
print("Vocabulary size (natural language)& {}& {} \\\\".format(len(set(" ".join(train_nl_examples).split())), len(set(" ".join(dev_nl_examples).split()))))
print("Vocabulary size (SQL)& {}& {} \\\\".format(len(set(" ".join(train_sql_examples).split())), len(set(" ".join(dev_sql_examples).split()))))

# Pre-process the data
import re
import string

def clean_text(text):
    text = text.lower()
    text = re.sub(r"([.,!?])", r" \1 ", text)
    text = re.sub(r"[^a-zA-Z.,!?]+", r" ", text)
    return text

def clean_sql(text):
    text = re.sub(r"([.,!?])", r" \1 ", text)
    text = re.sub(r"[^a-zA-Z0-9.,!?]+", r" ", text)
    return text

train_nl_examples = [clean_text(x) for x in train_nl_examples]
train_sql_examples = [clean_sql(x) for x in train_sql_examples]
dev_nl_examples = [clean_text(x) for x in dev_nl_examples]
dev_sql_examples = [clean_sql(x) for x in dev_sql_examples]

# get Statistics
train_nl_len = [len(x.split()) for x in train_nl_examples]
train_sql_len = [len(x.split()) for x in train_sql_examples]
dev_nl_len = [len(x.split()) for x in dev_nl_examples]
dev_sql_len = [len(x.split()) for x in dev_sql_examples]

print("Number of examples & {} & {} \\\\".format(len(train_nl_examples), len(dev_nl_examples)))
print("Mean sentence length & {}& {} \\\\".format(np.mean(train_nl_len), np.mean(dev_nl_len)))
print("Mean SQL query length & {}& {} \\\\".format(np.mean(train_sql_len), np.mean(dev_sql_len)))
print("Vocabulary size (natural language)& {}& {} \\\\".format(len(set(" ".join(train_nl_examples).split())), len(set(" ".join(dev_nl_examples).split()))))
print("Vocabulary size (SQL)& {}& {} \\\\".format(len(set(" ".join(train_sql_examples).split())), len(set(" ".join(dev_sql_examples).split()))))