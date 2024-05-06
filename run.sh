python train_t5.py --max_n_epochs 20 \
  --optimizer_type AdamW \
  --learning_rate 0.005 \
  --weight_decay 0.01 \
  --label_smoothing 0.1 \
  --scheduler_type cosine \
  --num_warmup_epochs 2 \
  --patience_epochs 10 \
  --experiment_name experiment \
  --batch_size 16 \
  --test_batch_size 16 \
  --use_wandb


#    --finetune \