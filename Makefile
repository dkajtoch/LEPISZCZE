upgrade:
	pip install --upgrade wheel setuptools build pip

install-poetry: upgrade
	pip install --no-cache-dir poetry==1.2.2

install:
	poetry install

#REMOTE_HOST := few-shot-pl-dk.europe-west4-a.sc-8395-kraken-prod
REMOTE_HOST := few-shot-pl-dk-a100.europe-west4-a.sc-8395-kraken-prod

rsync:
	rsync -rhv \
		--exclude '.ipynb_checkpoints' \
		--exclude '.idea' \
		--exclude '.mypy_cache' \
		--exclude '.pytest_cache' \
		--exclude '.venv' \
		--exclude '*.egg-info' \
		--exclude '__pycache__' \
		--exclude '*.npz' \
		--exclude 'mlruns' \
		--exclude 'outputs' \
		./  $(REMOTE_HOST):src/LEPISZCZE
