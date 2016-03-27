#!/bin/sh
### usage: ./update-graal-revision.sh [hg-id]

echo 
echo Update Graal Compiler

cd graal-core
git pull
GRAAL_REV=`git rev-parse HEAD`
cd ..

echo
echo "Commit update to ${GRAAL_REV}"
git commit -m "Updated graal-core to ${GRAAL_REV}"
