echo "Evaluating T5-SCR on the development set"
python evaluate.py --predicted_sql results/t5_scr_experiment_dev.sql \
--predicted_records records/t5_scr_experiment_dev.pkl \
--development_sql data/dev.sql \
--development_records records/ground_truth_dev.pkl


echo "Evaluating T5-FT on the development set"
python evaluate.py --predicted_sql results/t5_ft_experiment_dev.sql \
--predicted_records records/t5_ft_experiment_dev.pkl \
--development_sql data/dev.sql \
--development_records records/ground_truth_dev.pkl