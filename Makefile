upgrade:
	pip install --upgrade wheel setuptools build pip

install-poetry: upgrade
	pip install --no-cache-dir poetry==1.2.2

install:
	poetry install