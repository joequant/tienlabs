#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

source /tmp/proxy.sh

echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
export HOME=/home/user
export IPFS_PATH=/home/user/data/jsipfs

cd /home/user
chown user:user -R /home/user/git
usermod -aG wheel user
npm install -g --unsafe-perm=true --allow-root truffle
npm install -g --unsafe-perm=true --allow-root ganache-cli
npm install -g --unsafe-perm=true --allow-root ipfs
npm install -g --unsafe-perm=true --allow-root web3
pip3 install ariadne Flask

mkdir data
mkdir data/logs
mkdir data/ganache
cp /tmp/startup.sh /home/user/data
cp /tmp/CustomGenesis.json /home/user/data
cp /tmp/graphql-server.py /home/user/data
chmod a+x /home/user/data/startup.sh
geth --datadir /home/user/data/geth \
     init /home/user/data/CustomGenesis.json
chown -R user:user data .npm .node-gyp .config
sudo -u user jsipfs init
cat <<EOF >> /etc/sudoers
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF
