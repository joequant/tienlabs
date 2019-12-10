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

mkdir data
mkdir data/logs
mkdir data/ganache

cp /tmp/startup.sh /home/user/data
cp /tmp/CustomGenesis.json /home/user/data
cp /tmp/test-system.sh /home/user/data
chmod a+x /home/user/data/startup.sh
geth --datadir /home/user/data/geth \
     init /home/user/data/CustomGenesis.json

cp /tmp/graphql-server.mjs /home/user/data
cp /tmp/package.json /home/user/data
pushd data
npm install -g --unsafe-perm=true --allow-root --verbose
npm install -g --unsafe-perm=true --allow-root --verbose ganache-cli \
    truffle ipfs
pushd /usr/lib/node_modules
modclean -r -f
popd
pushd node_modules
modclean -r -f
popd
jsipfs init
popd
chown user:user -R /home/user/git
chown user:user -R /home/user/data
usermod -aG wheel user

chown -R user:user data .npm .node-gyp .config
cat <<EOF >> /etc/sudoers
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF