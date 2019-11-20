#!/bin/bash
cd $HOME
BLOCK=${BLOCK:-ganache}
export IPFS_PATH=/home/user/data/jsipfs
if [[ $BLOCK = "geth" ]] ; then
    /usr/bin/geth --datadir /home/user/data/geth \
		  --networkid 15 --rpc >> \
		  data/logs/geth.log 2>&1 &
else
    /usr/bin/ganache-cli --db /home/user/data/ganache \
			 -i="5777" \
			 -d \
			 --mnemonic="myth like bonus scare over problem client lizard pioneer submit female collect" \
			 >> data/logs/ganache.log 2>&1 &
fi
/home/user/data/graphql-server.py >> data/logs/graphql-server.log 2>&1 &
/usr/bin/jsipfs daemon >> data/logs/ipfs.log 2>&1 &
exec /bin/bash
