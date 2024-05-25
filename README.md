# text-to-sql-t5

## Environment

It's highly recommended to use a virtual environment (e.g. conda, venv) for this assignment.

Example of virtual environment creation using conda:
```
conda create -n env_name python=3.10
conda activate env_name
python -m pip install -r requirements.txt
```

## Evaluation commands

If you have saved predicted SQL queries and associated database records, you can compute F1 scores using:
```
python evaluate.py
  --predicted_sql results/t5_ft_dev.sql
  --predicted_records records/t5_ft_dev.pkl
  --development_sql data/dev.sql
  --development_records records/ground_truth_dev.pkl
```


For database records, ensure that the name of the submission files (in the `records/` subfolder) are:
- `{t5_ft, ft_scr, gemma}_test.pkl`

Note that the predictions in each line of the .sql file or in each index of the list within the .pkl file must match each natural language query in 'data/test.nl' in the order they appear.

For the LLM, even if you experimented with both models, you should submit only one `.sql` file and one `.pkl` file, corresponding to the model of your choice. Do not submit separate result files for each model.
