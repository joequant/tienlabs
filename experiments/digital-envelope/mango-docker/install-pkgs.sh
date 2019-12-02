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
npm install -g --unsafe-perm=true --allow-root --verbose ipfs truffle \
    ganache-cli web3 express graphql-upload \
    express-graphql graphql graphql-upload modclean \
    child_process util --save

pushd /usr/lib/node_modules
modclean -r -f
popd

mkdir data
mkdir data/logs
mkdir data/ganache

jsipfs init
cp /tmp/startup.sh /home/user/data
cp /tmp/CustomGenesis.json /home/user/data
cp /tmp/test-system.sh /home/user/data
chmod a+x /home/user/data/startup.sh
geth --datadir /home/user/data/geth \
     init /home/user/data/CustomGenesis.json

cp /tmp/graphql-server.mjs /home/user/data
pushd data
npm link express express-graphql graphql child_process util
popd
chown -R user:user data .npm .node-gyp .config
cat <<EOF >> /etc/sudoers
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF
