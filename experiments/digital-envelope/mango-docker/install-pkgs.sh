#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

cat <<EOF >> /etc/dnf/dnf.conf
fastestmirror=true
excludepkgs=filesystem,chkconfig
max_parallel_downloads=10
EOF

source /tmp/proxy.sh

dnf upgrade --best --nodocs --allowerasing --refresh -y -x chkconfig -x filesystem

# Refresh locale and glibc for missing latin items
# needed for R to build packages

#dnf shell -v -y --setopt=install_weak_deps=False  --refresh <<EOF
#reinstall --best --nodocs --allowerasing locales locales-en glibc
#run
#EOF

#repeat packages in setup
dnf --setopt=install_weak_deps=False --best --allowerasing install \
    -v -y --nodocs \
    git \
    golang \
    make \
    nodejs \
    python3-docutils

echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
useradd user
chmod a+rx ~user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin
cd ~user
mkdir git
pushd git
git clone https://github.com/ethereum/go-ethereum
pushd go-ethereum
make geth
popd
git clone https://github.com/ipfs/go-ipfs
pushd go-ipfs
make install
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

chown user:user -R /home/user/git

mkdir data
mkdir logs
cp /tmp/startup.sh /home/user/data/startup.sh
chmod a+x /home/user/data/startup.sh
