# Django Web Server

A simple Django web server with a homepage.

## Setup (Local Development)

1. Create a virtual environment:
   ```
   python -m venv venv
   ```

2. Activate the virtual environment:
   - Windows:
     ```
     venv\Scripts\activate
     ```
   - macOS/Linux:
     ```
     source venv/bin/activate
     ```

3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Run migrations:
   ```
   python manage.py migrate
   ```

5. Start the development server:
   ```
   python manage.py runserver
   ```

6. Visit http://127.0.0.1:8000/ in your browser to see the homepage.

## Docker Setup

1. Build and start the Docker containers:
   ```
   docker-compose up -d --build
   ```

2. Run migrations inside the Docker container:
   ```
   docker-compose exec web python manage.py migrate
   ```

3. Visit http://localhost:8000/ in your browser to see the homepage.

4. To stop the Docker containers:
   ```
   docker-compose down
   ```

## Production Deployment

For production deployment, consider:
- Using a proper database like PostgreSQL instead of SQLite
- Setting up HTTPS with a proper SSL certificate
- Configuring environment variables for sensitive information
- Setting DEBUG=0 in production 