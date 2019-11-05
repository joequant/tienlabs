#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

source /tmp/proxy.sh

echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
export HOME=/home/user

cd /home/user
chown user:user -R /home/user/git
npm install -g  --unsafe-perm=true --allow-root truffle ganache-cli

mkdir data
mkdir logs
cp /tmp/startup.sh /home/user/data/startup.sh
chmod a+x /home/user/data/startup.sh
