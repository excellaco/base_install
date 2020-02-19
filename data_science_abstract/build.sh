#!/bin/bash

docker build . --no-cache --build-arg SSH_PRIVATE_KEY="`cat id_rsa`" -t base_install_setup