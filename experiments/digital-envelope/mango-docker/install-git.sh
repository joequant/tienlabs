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

cd ~user
mkdir git
pushd git
git clone https://github.com/ethereum/go-ethereum.git
pushd go-ethereum
make geth
popd
git clone https://github.com/ipfs/go-ipfs.git
pushd go-ipfs
make build GOFLAGS=--tags=openssl
popd
git clone https://github.com/joequant/mango-admin.git
pushd mango-admin
npm install -g
popd
git clone https://github.com/joequant/git-remote-mango.git
pushd git-remote-mango
npm install -g
popd
git clone https://github.com/joequant/git-remote-gcrypt.git
pushd git-remote-gcrypt
./install.sh
popd
git clone https://github.com/joequant/mango
popd

git config --unset --global http.proxy || true
git config --unset --global http.sslVerify || true
git config --unset --global url."$GIT_PROXY".insteadOf || true

