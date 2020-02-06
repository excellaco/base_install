FROM python:latest

# Run this before copying requirements for cache efficiency
RUN pip install --upgrade pip

# Add dependencies. [requirements.txt, data_methods, configuration files]
COPY requirements.txt /tmp
ADD opt /tmp/opt
ADD data_methods /tmp/data_methods
WORKDIR /tmp
RUN pip install -r requirements.txt
RUN pip install jupyter

# Run Jupyter
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]