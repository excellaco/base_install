# ubiquitous-python-packages
This repository consists of a bunch of Dockerfiles & requirements.txt files for pip installations. 

**To build a docker image with a image alias:**
docker build -t *<image_alias>* *<folder_path_of_dockerfile>*

**Run a docker image by calling the image alias:**
docker run -it -p <port:port> <image_alias>

**Run a docker container:**

1: Run docker ps to see all instances.

2: docker run -it -d --name *<container_alias>* *<image_to_base_off_alias>* " -> This will return an ID like 5f76df2605af1ce0fv91a9aba2526ab8deb119b28968f0037b3e7f832de3c98j

**How to pause a container: (Pause the processes running in a container)**

1: docker pause *<container_id>* or docker pause *<container_name>*

**How to unpause a container: (Unpause the processes running in a container)**

1: docker unpause *<container_id>* or docker unpause *<container_name>*

