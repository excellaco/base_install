#!/bin/bash

set -e

jupyter notebook --no-browser --allow-root --port 8888 --ip 0.0.0.0 --NotebookApp.token='local-development'
