# Instead of using conda activate, there's another way to run a command inside an environment. 
# conda run -n [environment_name] [your-command] will run command in environment.

# Download base image and set working directory
FROM continuumio/miniconda3:latest

# Make configuration directory, then switch back to /app.

WORKDIR /app

# Linux
RUN apt-get update && apt-get install -y build-essential && \
    conda update -n base conda && \
    conda update --all
    
## Install Python utilities
RUN conda install -c conda-forge tqdm

# Add code from GitHub to working directory if applicable

# Add additional files to working directory
COPY docker-entrypoint.sh .
COPY hello_world.py .
COPY opt ./opt
COPY notebooks ./notebooks

# TensorFlow
RUN conda install -c conda-forge tensorflow
RUN pip install tflearn
RUN pip install keras

# Create the environment. Also install Jupyter & set permissions for our entrypoint script.
COPY environment.yml .
RUN conda update -n base -c defaults conda && \
   conda env create -f environment.yml
   
# Make RUN commands use the new environment. (Activate environment)
SHELL ["conda", "run", "-n", "base_install", "/bin/bash", "-c"]

# XGBoost
RUN pip install xgboost
   
# Jupyter Notebook
EXPOSE 8888

RUN chmod +x docker-entrypoint.sh

# Code to execute when the container is started
ENTRYPOINT ["conda", "run", "-n", "base_install", "./docker-entrypoint.sh"]
#CMD python hello_world.py
