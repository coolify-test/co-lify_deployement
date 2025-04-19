#!/bin/bash
#set -e
cat << EOF
        __  __._              ._
  __/ __\/ __\| __ __  |  |   __
/ _ \   _\\   _\|  |/ _\\_  \ |  |  /  __/
\  _/|  |   |  |  |  \  \_ / _ \|  |\__ \
 \_  >_|   ||  ||\_  >_  /_/_  >
     \/                     \/     \/          \/
EOF

echo "Running the project"
echo "Installing requirements..."
pip install -r requirements.txt

echo "Running migrations..."
python manage.py makemigrations --merge
python manage.py migrate

echo "  "
echo "============================"
echo "Running Test and Sonar..."
echo "============================"
python manage.py test

if [ $? -ne 0 ]; then
  echo " "
  echo "❌ Test step failed, please fix before pushing."
  exit 1
fi


echo "Collection statics"
echo 'yes' | python manage.py collectstatic --noinput

sleep 5

echo "** Number of workers ${GUNICORN_WORKERS}"
echo "** Version ${VERSION}"
echo "** Starting gunicorn..."
gunicorn ARCEDIG.wsgi:application -b 0:8000 -w "${GUNICORN_WORKERS}" --log-level DEBUG --reload --threads=10 --timeout=3600