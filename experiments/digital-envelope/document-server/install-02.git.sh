#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

source /tmp/proxy.sh

echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
useradd user
chmod a+rx ~user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin

if [[ ! -z "$http_proxy" ]] ; then
    git config --global http.proxy $http_proxy
    if [[ ! -z "$GIT_PROXY" ]] ; then
	git config --global url."$GIT_PROXY".insteadOf https://
    fi
    git config --global http.sslVerify false
fi

npm install -g --unsafe-perm=true --allow-root --verbose modclean
cd ~user
mkdir code
pushd code
git clone https://github.com/ethereum/go-ethereum.git --depth=1
pushd go-ethereum
make geth
popd
#git clone https://github.com/ipfs/go-ipfs.git --depth=1
#pushd go-ipfs
#make build GOFLAGS=--tags=openssl
#popd
git clone https://github.com/joequant/mango-admin.git -b dev/work
pushd mango-admin
npm install -g
pushd /usr/lib/node_modules
modclean -r -f
popd
popd

git clone https://github.com/joequant/git-remote-mango.git
pushd git-remote-mango
npm install --verbose
pushd node_modules
modclean -r -f
popd
pushd /usr/bin
ln -s ../../home/user/code/git-remote-mango/git-remote-mango .
popd
popd
git clone https://github.com/joequant/git-remote-gcrypt.git
pushd git-remote-gcrypt
./install.sh
popd
git clone https://github.com/joequant/mango

pushd go-ethereum
mv build/bin/geth /usr/bin
popd

#pushd go-ipfs
#mv cmd/ipfs/ipfs /usr/bin
#popd
popd

git config --unset --global http.proxy || true
git config --unset --global http.sslVerify || true
git config --unset --global url."$GIT_PROXY".insteadOf || true

