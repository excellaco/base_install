# base_install
The intent of the base install repository is to ease the workflow for developers by removing the pain of configuring a development environment per project.

In this repository, we have a Dockerfile that includes Jupyter Notebooks for quick prototyping & Conda for Python dependencies.
This allows our team to deploy and reproduce our models in a robust preconfigured environment.

### Quick Review - ### 

- **Image**: Blueprint. Containers are instances of an image.
- **Dockerfile**: List of commands in a file used to create and update Docker Images.
- **Docker-Compose**: Tool used to define and launch Docker applications.

### docker-entrypoint.sh - ### 

- `--allow-root`: Needed since we use root to launch docker.
- `--port 8888`: Must be the same as docker's port for Jupyter Notebook.
- `--ip 0.0.0.0`: Reassign Jupyter Notebook server's IP.

### To build a docker image - ### 

```
docker-compose build
```

To check docker images -

```
docker images
```

### Create a docker container:### 

```
docker-compose up
```

Run docker compose in background:

```
docker-compose up -d
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
- To remove all of the stopped docker containers: docker rm $(docker ps -q -f status=exited) 
- To remove all Docker images: docker rmi -f $(docker images -a -q) & docker image prune -f 

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

After retagging, we can just use docker-compose up to launch Docker.

### Local Development or Production Use?### 

Inside of the README, you will see -

```
# Add additional files to working directory
COPY docker-entrypoint.sh .
COPY hello_world.py .

# Code to execute when the container is started
#ENTRYPOINT ["conda", "run", "-n", "base_install", "./docker-entrypoint.sh"]
CMD python hello_world.py
```

Replace hello world with the code you will want to run to start your application. For local development, uncomment entrypoint and comment out the CMD statement. For production use, keep entrypoint commented out, and leave uncommented the CMD statement.

### Database Development in Jupyter Notebook ### 

Open up a terminal command through Jupyter and execute - 

```
/etc/init.d/mysql start
```

Will also need to modify python_config.ini to have the appropriate credentials.


