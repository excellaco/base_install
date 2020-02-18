# Download base image and set working directory
FROM ubuntu:16.04

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

# Add code from GitHub to working directory if applicable

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
