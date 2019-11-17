#!/bin/bash
cd $HOME
BLOCK=${BLOCK:-ganache}
if [[ $BLOCK = "geth" ]]
then
/usr/bin/geth --datadir /home/user/test-net-blockchain \
	      --networkid 15 --rpc >> \
	      data/logs/geth.log 2>&1 &
else
    /usr/bin/ganache-cli >> data/logs/ganache.log 2>&1 &
fi
/usr/bin/ipfs daemon >> data/logs/ipfs.log 2>&1 &
exec /bin/bash
