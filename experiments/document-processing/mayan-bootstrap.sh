#!/bin/bash
# instructions from https://docs.mayan-edms.com/topics/docker.html

set -e

mkdir -p mayan
mkdir -p postgres
chmod a+rwx mayan postgres

docker network create mayan

docker pull mayanedms/mayanedms:latest
docker pull postgres:12
docker run -d \
       --name mayan-edms-postgres \
       --network=mayan \
       --restart=always \
       -e POSTGRES_USER=mayan \
       -e POSTGRES_DB=mayan \
       -e POSTGRES_PASSWORD=mayanuserpass \
       -v `pwd`/postgres:/var/lib/postgresql/data \
       postgres:12

sleep 60

docker run \
       --name mayan-edms \
       --restart=always \
       --network=mayan \
       -p 81:8000 \
       -e MAYAN_DATABASE_ENGINE=django.db.backends.postgresql \
       -e MAYAN_DATABASE_HOST=mayan-edms-postgres \
       -e MAYAN_DATABASE_NAME=mayan \
       -e MAYAN_DATABASE_PASSWORD=mayanuserpass \
       -e MAYAN_DATABASE_USER=mayan \
       -e MAYAN_DATABASE_CONN_MAX_AGE=0 \
       -v `pwd`/mayan:/var/lib/mayan \
       mayanedms/mayanedms:latest
