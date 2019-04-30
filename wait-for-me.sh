#!/bin/sh
# wait-for-postgres.sh

set -e

host="$1"
shift
cmd="$@"

echo "$host 654"
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# python3 ./manage.py migrate && \
# python3 ./manage.py updatecatalog && \
python3 ./manage.py runserver 0.0.0.0:8000

>&2 echo "Postgres is up - executing command"
exec $cmd