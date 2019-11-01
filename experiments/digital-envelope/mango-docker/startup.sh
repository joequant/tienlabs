#!/bin/bash
cd $HOME
./git/go-ethereum/build/bin/geth >& logs/geth.log 2>&1
exec /bin/bash
