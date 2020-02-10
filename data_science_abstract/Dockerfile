# Download base image/
FROM continuumio/miniconda3:latest

# Add the environment.yml file, which contains all of our Python dependencies.
# For projects requiring different packages, just modify the environment.yml file to include all of the Python packages you need.
ADD environment.yml /

# Update the current environment based on environment.yml file and install from base_install.
RUN conda update -n base -c defaults conda
RUN conda update -n base conda && conda env update
#RUN conda activate base

# Retrieve our code from GitHub.

# Entrypoint: In short, if no parameters are passed, the default is to boot up with JupyterLab and Visual Studio.
# If we want to execute a script, we pass that in as a parameter.
# With this setup, we can develop locally or run production applications when they are ready.
# To pass an argument - add in the line after ENTRYPOINT, CMD ["python (script_name)"]

COPY docker_entrypoint.sh /tmp
ADD code /tmp/code
ADD opt /tmp/opt
ADD data_methods /tmp/data_methods
WORKDIR /tmp

ENTRYPOINT ["docker_entrypoint.sh"]
