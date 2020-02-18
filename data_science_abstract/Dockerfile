# Create a temporary image to securely clone code repository.
FROM ubuntu:18.04 as clone-repo-temp

USER root

RUN apt-get update

# Installing Git..
RUN apt-get install -y git

# Add ssh key as a build argument, passed with --build-arg or in the build block of your docker-compose.yml file
# Instrutions:
#   a. generate key with 'ssh-keygen -f ./id_rsa' (on the Dockerfile folder)
#   b. add id_rsa.pub to 'SSH keys and GPG keys' in github profile settings
#   c. docker build --build-arg SSH_PRIVATE_KEY="`cat id_rsa`" .
#      Example using key file stored online: docker build --build-arg SSH_PRIVATE_KEY="`curl https://gist.githubusercontent.com/nampereira/9d32b24f167e58e1705dbb9106471dfe/raw/12ec0d21dbc293da915e23a1868f58c1a7bb4937/rsa_id`" .
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Make sure bitbucket.org is a known host
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

WORKDIR /
RUN git clone --recursive git@github.com:bcashofficial/housing_prices.git

WORKDIR /housing_prices
RUN git checkout master && git pull

# Download base image and set working directory
FROM ubuntu:18.04

USER root

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
COPY opt ./opt
COPY data_methods ./data_methods

# Copy repository from temporary image
RUN sudo mkdir /housing_prices
COPY --from=clone-repo-temp /housing_prices ./housing_prices 

# Add Python dependencies
RUN pip install keras && \
   pip install matplotlib && \
   pip install numpy && \
   pip install pandas && \
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
ENTRYPOINT ./docker-entrypoint.sh; bash
