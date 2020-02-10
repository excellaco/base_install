# Download base image ubuntu:18.04
FROM ubuntu:18.04

# Update Ubuntu software repository.
RUN apt-get update && apt-get install -y apt-transport-https

# Download Python 3
RUN apt-get -y install python3.6

# Download Git
RUN apt-get install git-core

# Download MySQL
#RUN apt-get install mysql-server
#RUN mysql_secure_installation

# Have conda installed

# Run this before copying requirements for cache efficiency
# RUN pip install --upgrade pip

# Add dependencies. [requirements.txt, data_methods, configuration files]
# COPY requirements.txt /tmp
# ADD opt /tmp/opt
# ADD data_methods /tmp/data_methods
# WORKDIR /tmp
# RUN pip install -r requirements.txt
# RUN pip install jupyter

# Run Jupyter
# CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]