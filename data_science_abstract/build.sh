#!/bin/bash

docker build . --no-cache --build-arg SSH_PRIVATE_KEY="`cat housing_prices_id_rsa`" -t base_install_setup