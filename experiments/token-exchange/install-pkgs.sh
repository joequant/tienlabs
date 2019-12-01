#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v
source /tmp/proxy.sh
useradd user --home /home/user
mkdir /home/user
chmod a+rx ~user

apt-get update
apt-get -y install git sudo npm nodejs apt-utils
cd ~user
mkdir git
pushd git
git clone https://github.com/joequant/nydax
pushd nydax/bin
./install.sh
popd
popd

chown user:user -R /home/user/git
usermod -aG wheel user
cat <<EOF >> /etc/sudoers
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF
