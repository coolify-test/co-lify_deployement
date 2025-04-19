#!/bin/bash
echo "Installing requirements..."
pip install -r requirements.txt
echo "Running migrations..."
python manage.py makemigrations --merge
python manage.py migrate
echo "Collection statics"
echo 'yes' | python manage.py collectstatic --noinput
sleep 5
# gunicorn core.wsgi:application -b 0:8001 -w "${GUNICORN_WORKERS}" --log-level DEBUG --reload --threads=10 --timeout=3600
gunicorn core.wsgi:application -b 0:8001 -w "${GUNICORN_WORKERS}" --log-level DEBUG --threads=10 --timeout=3600
