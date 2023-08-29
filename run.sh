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
#  polemo2
#  nkjp_ner
#  dyk
  cst_wikinews
  cbd
  cdsc_e
  abusive_clauses
)
item=allegro__herbert-large-cased

for task in "${TASK_NAME[@]}"
do
  run_data_preprocessing
  run_data_preprocessing_hps
  # HPS scripts breaks deterministically.
  run_hps || true
  run_evaluation
done
