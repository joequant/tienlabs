sudo rm -rf postgres
rm -rf mayan
docker stop mayan-edms
docker stop mayan-edms-postgres
docker rm mayan-edms
docker rm mayan-edms-postgres
docker network rm mayan
