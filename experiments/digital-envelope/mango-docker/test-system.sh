#!/bin/bash

cd $HOME
export REPO=$(mango-admin create | grep Repo | awk '{print $3;}')
export DEBUG="*"
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
echo $REPO
git clone mango://$REPO
cd $REPO
cat <<EOF > out.txt
test
test
EOF
git add out.txt
git commit -m "test"
git push
