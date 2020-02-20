#!/bin/bash

docker build . --no-cache --build-arg SSH_PRIVATE_KEY="`cat housing_prices_id_rsa`" --build-arg REPO_TO_CLONE="git@github.com:bcashofficial/housing_prices.git" --build-arg REPOSITORY_DIR="housing_prices" --build-arg RUN_SCRIPT="PROD" --build-arg PROD_FOLDER="housing_prices" --build-arg PROD_SCRIPT_COMMAND="python linear_regression.py" -t base_install_setup