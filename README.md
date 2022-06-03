# basic-python-project-generator

Initialize a default structure for Python project

## Run

```bash
bash init_python_project.sh
```

## Structure

```
your-project-name
  |- .flake8
  |- pyproject.toml
  |- poetry.lock
  |- Makefile
  |- README.md
  |- src/
```

## Default dependencies

By default the following python dependencies will be installed.

- flake8
- vulture
- black
- pytest
- isort
- bandit

## Default configuration

By default, the dependencies will be set with a line-length
 to 120.

## Makefile

Default Makefile commands:

- lint: to run flake8, vulture, black and isort
- check-secu: to run bandit
- test: to run pytest on src/ folder
