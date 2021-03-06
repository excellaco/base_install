# base_install
The intent of the base install repository is to ease the workflow for developers by removing the pain of configuring a development environment per project.

### Quick Review - ### 

- **Image**: Blueprint. Containers are instances of an image.
- **Dockerfile**: List of commands in a file used to create and update Docker Images.
- **Docker-Compose**: Tool used to define and launch Docker applications.

### Dockerfile - ### 

Dockerfile creates an Ubuntu server with Python, Jupyter, and MySQL, before calling our docker-entrypoint.sh script.

### To build a docker image - ### 

SSH Instructions if necessary. This is to add to code repositories where we are pulling code.

- 1: Generate key with 'ssh-keygen -f ./id_rsa' (on the Dockerfile folder)
- 2: Add id_rsa.pub as an SSH key in GitHub.

Build steps underneath. Review the build.sh file to ensure build arguments are properly set. Modifying the build arguments are the only manual portion of this process.

```
chmod +x build.sh
./build.sh
```

To check docker images -

```
docker images
```

### Run a docker container:### 

```
docker run -it -p 8888:8888 -p 3306:3306 base_install_setup
```

Check docker containers:

```
docker ps -a
```

### Access Jupyter Notebook:### 

```
http://0.0.0.0:8888
```

### How to pause a container: (Pause the processes running in a container)### 

```
docker pause *<container_id>* or docker pause *<container_name>*
```

### How to unpause a container: (Unpause the processes running in a container)### 

```
docker unpause *<container_id>* or docker unpause *<container_name>*
```

- Important to note, start, stop, restart, kill, and rm (destroy) all follow the same syntax.
- To stop all running docker containers: *docker stop $(docker ps -a -q)*
- To remove all of the stopped docker containers: docker rm $(docker ps -q -f status=exited) OR docker ps -aq --no-trunc -f status=exited | xargs docker rm
- To remove all Docker images: docker rmi -f $(docker images -a -q) OR docker image prune -f 

### Push our image to DockerHub:### 

```
# Rebuild Docker Image
docker build -t <image_alias>

# Retag docker image
docker tag <tag_name> <image_alias>

# Push to Docker Hub
docker push <image_alias>
```

### Pull our image from DockerHub:### 

```
# Pull from Docker Hub
docker pull <image_alias>

# Retag docker image
docker tag <tag_name> <image_alias>
```


