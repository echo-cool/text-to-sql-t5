import os
import re


def read_schema(schema_path):
    """
    Read the .schema file
    """
    with open(schema_path, "r") as f:
        schema = f.readlines()
        schema = [line.strip() for line in schema]
    return schema


def extract_sql_query(response):
    """
    Extract the SQL query from the model's response
    """
    pattern = r"```(?:sql)?(.*?)```"

    match = re.search(pattern, response, re.DOTALL)

    if match:
        return match.group(1).strip()
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
