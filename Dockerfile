FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# Create staticfiles directory with proper permissions
RUN mkdir -p /app/staticfiles && chmod -R 777 /app/staticfiles

# Expose port
EXPOSE 8080

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos '' django-user
RUN chown -R django-user:django-user /app
USER django-user

# Run the application
ENTRYPOINT ["/app/entrypoint.sh"] 