# Instead of using conda activate, there's another way to run a command inside an environment. 
# conda run -n [environment_name] [your-command] will run command in environment.

# Download base image and set working directory
FROM continuumio/miniconda3:latest
WORKDIR /app

# Add additional files to working directory
COPY /opt .
COPY /data_methods .
COPY docker-entrypoint.sh .

# Add code from GitHub to working directory if applicable

# Create the environment. Also install Jupyter & set permissions for our entrypoint script.
COPY environment.yml .
RUN conda update -n base -c defaults conda && \
   conda env create -f environment.yml && \
   pip install jupyter && \
   chmod 777 docker-entrypoint.sh
   
# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "base_install", "/bin/bash", "-c"]

# Code to execute when the container is started
ENTRYPOINT ["conda", "run", "-n", "base_install", "./docker-entrypoint.sh"]
