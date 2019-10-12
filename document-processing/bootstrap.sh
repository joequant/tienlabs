#!/bin/bash
# instructions from https://docs.mayan-edms.com/topics/docker.html

set -e

docker pull mayanedms/mayandms:latest
docker pull postgres:9.6
docker run -d \
--name mayan-edms-postgres \
--restart=always \
-p 5432:5432 \
-e POSTGRES_USER=mayan \
-e POSTGRES_DB=mayan \
-e POSTGRES_PASSWORD=mayanuserpass \
-v /docker-volumes/mayan-edms/postgres:/var/lib/postgresql/data \
       -d postgres:9.6

docker run -d \
--name mayan-edms \
--restart=always \
-p 80:8000 \
-e MAYAN_DATABASE_ENGINE=django.db.backends.postgresql \
-e MAYAN_DATABASE_HOST=172.17.0.1 \
-e MAYAN_DATABASE_NAME=mayan \
-e MAYAN_DATABASE_PASSWORD=mayanuserpass \
-e MAYAN_DATABASE_USER=mayan \
-e MAYAN_DATABASE_CONN_MAX_AGE=0 \
-v /docker-volumes/mayan-edms/media:/var/lib/mayan \
mayanedms/mayanedms:latest
