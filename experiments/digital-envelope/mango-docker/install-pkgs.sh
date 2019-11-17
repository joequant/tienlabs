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
usermod -aG wheel user
npm install -g  --unsafe-perm=true --allow-root truffle ganache-cli
npm install -g  --unsafe-perm=true --allow-root web3
pushd git/go-ethereum
mv build/bin/geth /usr/bin
popd

pushd git/go-ipfs
mv cmd/ipfs/ipfs /usr/bin
popd

mkdir data
mkdir data/logs
cp /tmp/startup.sh /home/user/data
cp /tmp/CustomGenesis.json /home/user/data
chmod a+x /home/user/data/startup.sh
chown -R user:user data .npm .node-gyp .config

geth --datadir /home/user/data/test-net-blockchain \
     init /home/user/data/CustomGenesis.json
sudo -u user ipfs init
cat <<EOF >> /etc/sudoers
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF
