VENV := .venv
PYTHON := $(VENV)/bin/python

.PHONY: venv install test lint fetch sync push status

venv:
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip

install: venv
	$(PYTHON) -m pip install -e ".[dev]"

test:
	$(PYTHON) -m pytest

lint:
	$(PYTHON) -m ruff check .

# Fetch latest changes from your fork (origin) and the original repo (upstream)
fetch:
	git fetch origin
	git fetch upstream

# Pull upstream's main into your local main, then push the result to your fork
sync: fetch
	git merge upstream/main
	git push origin main

# Push your local commits to your fork
push:
	git push origin main

status:
	git status
	git remote -v
