#!/bin/bash
cd $HOME
BLOCK=${BLOCK:-ganache}
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
node --experimental-modules /home/user/data/graphql-server.mjs >> data/logs/graphql-server.log 2>&1 &

if [[ ! -z "${IPFS_URI}" ]]; then
    /usr/bin/jsipfs daemon >> data/logs/ipfs.log 2>&1 &
fi

gitea web  -c /etc/gitea/app.ini >> data/log/gitea.log &
exec /bin/bash
