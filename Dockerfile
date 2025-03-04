# Use a slim Python image for minimal size
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install system dependencies and clean up
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files into the container
COPY . .

# Make the entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Set permissions for the static files directory
RUN mkdir -p /app/staticfiles && chmod -R 777 /app/staticfiles

# Expose the correct port for Django
EXPOSE 8080

# Set an environment variable for Django's default port
ENV DJANGO_PORT=8080

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos '' django-user \
    && chown -R django-user:django-user /app

# Switch to the non-root user
USER django-user

# Run the application
ENTRYPOINT ["/app/entrypoint.sh"]
