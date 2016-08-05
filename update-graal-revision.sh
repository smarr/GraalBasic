#!/bin/sh
### usage: ./update-graal-revision.sh [hg-id]

echo
echo Update JVMCI

cd graal-jvmci-8
git fetch
git pull
cd ..

cd mx
git pull
cd ..


echo 
echo Update Graal Compiler
cd graal-core
git pull graalvm master
git push smarr master
../mx/mx sforceimport
GRAAL_REV=`git rev-parse HEAD`
cd ..


echo
echo "Commit update to ${GRAAL_REV}"
git add graal-jvmci-8
git add graal-core
git add mx
git add truffle
git commit -m "Updated graal-core to ${GRAAL_REV}"
