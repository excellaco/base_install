FROM python:latest

# Run this before copying requirements for cache efficiency
RUN pip install --upgrade pip

# Add dependencies.
COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip install -r requirements.txt
RUN pip install jupyter

# What port are we working under.
# EXPOSE 8888

# Run Jupyter
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
#CMD /bin/bash