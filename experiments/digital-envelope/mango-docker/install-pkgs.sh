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
dnf shell -v -y --setopt=install_weak_deps=False  --refresh <<EOF
reinstall --best --nodocs --allowerasing locales locales-en glibc
run
EOF

#repeat packages in setup
dnf --setopt=install_weak_deps=False --best --allowerasing install \
    -v -y --nodocs \
    git


echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
useradd user
chmod a+rx ~user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin
cd ~user
mkdir git
cd git
