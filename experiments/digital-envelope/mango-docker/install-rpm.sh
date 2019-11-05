#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
set -e -v

source /tmp/proxy.sh

#urpmi.removemedia -a
#urpmi.addmedia --distrib --mirrorlist http://mirrors.mageia.org/api/mageia.7.x86_64.list
urpmi.update -a
urpmi --no-recommends --excludedocs --auto \
    git \
    golang \
    gcc-c++ \
    make \
    nodejs \
    python3-docutils

