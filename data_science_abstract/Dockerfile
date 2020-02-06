FROM python:latest

# Run this before copying requirements for cache efficiency
RUN pip install --upgrade pip

RUN pip install -r requirements.txt
ENTRYPOINT ['python3']