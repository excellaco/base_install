#!/bin/bash

docker build . --no-cache --build-arg SSH_PRIVATE_KEY="`cat housing_prices_id_rsa`" --build-arg REPO_TO_CLONE="git@github.com:bcashofficial/housing_prices.git" -t base_install_setup