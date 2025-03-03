#!/bin/sh

# Wait for the database to be ready
if [ "$DATABASE_URL" != "sqlite:///db.sqlite3" ]; then
    echo "Waiting for PostgreSQL..."
    
    while ! nc -z db 5432; do
      sleep 0.1
    done
    
    echo "PostgreSQL started"
fi

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start server
echo "Starting server..."
gunicorn --bind 0.0.0.0:8000 mysite.wsgi:application 