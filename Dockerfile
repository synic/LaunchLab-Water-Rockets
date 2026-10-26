FROM python:3.14-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN SECRET_KEY=build-only \
    REDIS_URL=redis://localhost:6379/0 \
    DB_NAME=x DB_USER=x DB_PASSWORD=x DB_HOST=localhost DB_PORT=5432 \
    python manage.py collectstatic --noinput

EXPOSE 8000

ENTRYPOINT ["docker/entrypoint.sh"]
