#!/bin/sh
### usage: ./update-graal-revision.sh [hg-id]

echo 
echo Update Graal Compiler

cd graal-compiler
git pull graalvm master
git push smarr master
GRAAL_REV=`git rev-parse HEAD`
cd ..

cd mx
git pull
cd ..

echo
echo "Commit update to ${GRAAL_REV}"
git add graal-compiler
git add mx
git commit -m "Updated graal-core to ${GRAAL_REV}"
