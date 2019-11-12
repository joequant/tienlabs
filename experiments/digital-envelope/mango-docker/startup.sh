#!/bin/bash
cd $HOME
/usr/bin/geth --datadir /home/user/test-net-blockchain --networkid 15 --rpc >> \
    data/logs/geth.log 2>&1 &
/usr/bin/ipfs daemon >> data/logs/ipfs.log 2>&1 &
exec /bin/bash
