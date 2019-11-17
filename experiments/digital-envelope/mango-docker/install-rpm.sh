#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

source /tmp/proxy.sh

curl https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz | tar -C /usr/local -xzf -

pushd /usr/local/bin
ln -s ../go/bin/go .
popd
go help

#urpmi.removemedia -a
#urpmi.addmedia --distrib --mirrorlist http://mirrors.mageia.org/api/mageia.7.x86_64.list
urpmi.update -a
urpmi --no-recommends --excludedocs --auto \
    git \
    gcc-c++ \
    make \
    nodejs \
    python3-docutils \
    sudo \
    openssl-devel \
    gnupg2



