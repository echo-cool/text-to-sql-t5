import os
import re
import json
from functools import cache


@cache
def get_examples(data_folder):
    natural_language = []
    sql = []
    with open(os.path.join(data_folder, "dev.nl"), "r") as f:
        natural_language = f.readlines()
        natural_language = [line.strip() for line in natural_language]
    with open(os.path.join(data_folder, "dev.sql"), "r") as f:
        sql = f.readlines()
        sql = [line.strip() for line in sql]
    return list(zip(natural_language, sql))


@cache
def read_schema(schema_path):
    """
    Read the .schema file
    """
    schema = {}

    with open(schema_path, "r") as f:
        data = json.load(f)
        for table_name in data["ents"]:
            schema[table_name] = schema.get(
                table_name,
                {
                    "columns": [],
                },
            )
            for column in data["ents"][table_name]:
                schema[table_name]["columns"].append(column)

    return json.dumps(schema)


def extract_sql_query(response):
    """
    Extract the SQL query from the model's response
    """
    pattern = r"```(?:sql)?(.*?)```"

    match = re.search(pattern, response, re.DOTALL)

    if match:
        return match.group(1).strip().replace("\n", " ")
    else:
        return None


def save_logs(output_path, sql_em, record_em, record_f1, error_msgs):
    """
    Save the logs of the experiment to files.
    You can change the format as needed.
    """
    if not os.path.exists(os.path.dirname(output_path)):
        os.makedirs(os.path.dirname(output_path))
    with open(output_path, "w") as f:
        f.write(
            f"SQL EM: {sql_em}\nRecord EM: {record_em}\nRecord F1: {record_f1}\nModel Error Messages:\n"
        )
        for index, error_msg in enumerate(error_msgs):
            f.write(f"{index}: {error_msg}\n")
