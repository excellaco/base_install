# Create a temporary image to securely clone code repository.
FROM ubuntu:18.04 as clone-repo-temp

USER root

# Arguments for SSH Argument & repository arguments. Also argument for local development or production.
ARG SSH_PRIVATE_KEY
ARG REPO_TO_CLONE
ARG REPOSITORY_DIR

RUN apt-get update

# Installing Git..
RUN apt-get install -y git

# SSH Instructions
# 1: Generate key with 'ssh-keygen -f ./id_rsa' (on the Dockerfile folder)
# 2: Add id_rsa.pub as an SSH key in GitHub.
# 3: Run docker build --build-arg SSH_PRIVATE_KEY="`cat id_rsa`" .

RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Make sure bitbucket.org is a known host
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

WORKDIR /
RUN git clone --recursive ${REPO_TO_CLONE}

WORKDIR /${REPOSITORY_DIR}
RUN git checkout master && git pull

# Download base image and set working directory
FROM ubuntu:18.04

USER root

# Additional variables in new base image.
ARG RUN_SCRIPT=${RUN_SCRIPT}
ENV RUN_SCRIPT_GLOBAL=$RUN_SCRIPT

ARG PROD_FOLDER=${PROD_FOLDER}
ENV PROD_FOLDER_GLOBAL=$PROD_FOLDER

ARG PROD_SCRIPT_COMMAND=${PROD_SCRIPT_COMMAND}
ENV PROD_SCRIPT_COMMAND_GLOBAL=$PROD_SCRIPT_COMMAND

ARG PROD_SCRIPT_FILE=${PROD_SCRIPT_FILE}
ENV PROD_SCRIPT_FILE_GLOBAL=$PROD_SCRIPT_FILE

# Linux
RUN	apt-get update && apt-get install -y build-essential && \
	apt -y install openjdk-8-jdk openssh-client openssh-server rsync sudo vim git figlet python3 python3-pip

RUN sudo ln -s /usr/bin/python3 /usr/bin/python
    
# Install Jupyter
RUN pip3 install --upgrade pip
RUN pip install jupyter

# Install MySQL
RUN sudo apt update \
	&& sudo DEBIAN_FRONTEND=noninteractive apt -y install mysql-server \
	&& sudo usermod -d /var/lib/mysql/ mysql

# Create core_user
RUN adduser --disabled-password --gecos '' core_user
RUN adduser core_user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER core_user
WORKDIR /home/core_user

# Add additional files to working directory
COPY docker-entrypoint.sh .

# Copy repository from temporary image
COPY --from=clone-repo-temp /${REPOSITORY_DIR} . 

# Add Python dependencies
RUN pip install keras && \
   pip install matplotlib && \
   pip install numpy && \
   pip install pandas && \
   pip install -U protobuf==3.8.0 && \
   pip install pymysql && \
   pip install scikit-learn && \
   pip install scipy && \
   pip install seaborn && \
   pip install sqlalchemy && \
   pip install statsmodels && \
   pip install tensorflow && \
   pip install tflearn && \
   pip install urllib3 && \
   pip install xgboost
   
# Expose Jupyter Notebook port & MySQL port
EXPOSE 8888
EXPOSE 3306
EXPOSE 22

# Give permissions for entrypoint and execute entrypoint.
RUN sudo chmod +x docker-entrypoint.sh
ENTRYPOINT ./docker-entrypoint.sh $RUN_SCRIPT_GLOBAL $PROD_FOLDER_GLOBAL $PROD_SCRIPT_COMMAND_GLOBAL $PROD_SCRIPT_FILE_GLOBAL
