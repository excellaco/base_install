FROM python:latest

# Run this before copying requirements for cache efficiency
RUN pip install --upgrade pip

# Add dependencies.
COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip install -r requirements.txt

# What port are we working under.
EXPOSE 8000

# Start python3
CMD ["python3"]