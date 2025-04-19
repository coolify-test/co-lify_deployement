#!/bin/sh

echo 'Running migrations...'
python manage.py migrate
echo 'Compressing static files...'
python manage.py compress --force
echo 'Collecting static files...'
python manage.py collectstatic --noinput --clear --no-post-process
echo 'Generating proxy config file...'
python manage.py generate_proxy_config

cd /code/src
exec "$@"