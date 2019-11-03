#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

source /tmp/proxy.sh

echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"

cd /home/user
chown user:user -R /home/user/git
chmod a+rx /root
npm install -g truffle ganache-cli

mkdir data
mkdir logs
cp /tmp/startup.sh /home/user/data/startup.sh
chmod a+x /home/user/data/startup.sh
