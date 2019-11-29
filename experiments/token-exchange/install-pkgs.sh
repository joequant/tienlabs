#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v
useradd user --home /home/user
mkdir /home/user
chmod a+rx ~user

apt-get update
apt-get install git
cd ~user
mkdir git
pushd git
git clone https://github.com/joequant/nydax
nydax/bin/install.sh
popd

chown user:user -R /home/user/git
usermod -aG wheel user
cat <<EOF >> /etc/sudoers
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF
