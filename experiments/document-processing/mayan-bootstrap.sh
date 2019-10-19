#!/bin/bash
# instructions from https://docs.mayan-edms.com/topics/docker.html

set -e

mkdir -p mayan
mkdir -p postgres
docker-compose up start_dependencies
sleep 15
docker-compose up mayan-edms
