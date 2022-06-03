#!/bin/bash


install_poetry() {
    echo "Installing poetry..."
    pip install poetry    
}

add_dependencies() {
    echo "Installing following dependentcies : $*"
    poetry add $*
}

configure_dependencies() {
    echo "[tool.black]
    line-length = 120
    target-version = ['py36', 'py37', 'py38', 'py39']
    include = '\.pyi?$'
    exclude = '''
    /(
        \.eggs
    | \.git
    | \.hg
    | \.mypy_cache
    | \.tox
    | \.venv
    | _build
    | buck-out
    | build
    | dist
    )/
    '''

    [tool.isort]
    profile = 'black'

    [tool.vulture]
    exclude = ['test*.py', 'tests/', 'settings.py']
    ignore_decorators = []
    ignore_names = []
    make_whitelist = false
    min_confidence = 80
    sort_by_size = true
    verbose = false
    " >> pyproject.toml

    echo "[flake8]
    max-line-length = 120
    extend-ignore = E203
    " > .flake8
}

create_makefile() {
    echo -e "lint:
\t - poetry run isort .
\t - poetry run black .
\t - poetry run flake8 .
\t - poetry run vulture .

check-secu:
\t - poetry run bandit -r .

test:
\t - poetry run pytest -v -s src/
" > Makefile
}

add_gitignore() {
curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore -o .gitignore

echo ".idea/
.vscode/" >> .gitignore
}

echo "Basic Python project creator"
echo "----------------------------"
echo "Enter your project name"
read projectName

echo "Do you have poetry installed ? (Y/n)"

read isPoetry

echo "Would you like download default Python .gitignore from Github ? (y/N)"
read isGitignore

if [[ "$isPoetry" ==  [nN] ]]
then
    install_poetry
fi

echo "Creating project structure..."
mkdir -p $projectName/src
cd $projectName

# ====================================================================
# Files creation
# ====================================================================
touch README.md
echo "# $projectName" > README.md

poetry init
echo "Installing default python dependencies..."
add_dependencies black isort flake8 vulture bandit pytest

configure_dependencies
create_makefile

if [[ "$isGitignore" == [yY] ]]
then
    add_gitignore
fi
