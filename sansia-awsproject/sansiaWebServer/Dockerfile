# Use Python runtime as a base image
FROM python:3.9-slim

# Set working directory in container
WORKDIR /app

# Copy application code to /app
COPY . /app

# Install dependencies
RUN apt-get update && apt-get install -y python3-venv
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install --upgrade pip
RUN /app/venv/bin/pip install -r requirements.txt
RUN /app/venv/bin/pip install gunicorn

# Expose the app's running port
EXPOSE 8080

# Set PATH to include venv
ENV PATH="/app/venv/bin:$PATH"

# Run the app with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
