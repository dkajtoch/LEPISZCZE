#!/bin/bash

export TOKENIZERS_PARALLELISM=false
rm dvc.lock
dvc repro
