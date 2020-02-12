#!/bin/bash

set -e

if [ $# -eq 0 ]
     then
          jupyter notebook --no-browser --allow-root --port 8888 --ip 0.0.0.0 --NotebookApp.token='local-development'
     else
          exec "$@"
fi
