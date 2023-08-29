#!/bin/bash

export TOKENIZERS_PARALLELISM=false

run_hps () {
  poetry run python experiments/scripts/hps/optimize_lightning_classification.py \
    --ds ${task} \
    --embedding-path ${item} \
    --hps-config-path experiments/configs/hps/lightning.yaml
}

run_evaluation () {
  poetry run python experiments/scripts/tasks/evaluate_lightning_classification.py \
    --ds ${task} \
    --embedding-path ${item} \
    --retrains 5
}

run_data_preprocessing () {
  poetry run python experiments/scripts/preprocess_dataset.py --ds ${task} --cfg-type lightning
}

run_data_preprocessing_hps () {
  poetry run python experiments/scripts/preprocess_dataset.py --ds ${task} --cfg-type lightning --is-hps
}

TASK_NAME=(
  cst_wikinews
  cbd
  cdsc_e
  abusive_clauses
)
item=allegro__herbert-large-cased

for task in "${TASK_NAME[@]}"
do
  # HPS scripts breaks deterministically.
  rm -rf dvc.lock
  dvc repro || true
  run_evaluation
done
