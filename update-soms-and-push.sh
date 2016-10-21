#!/bin/sh
set -e

./update-submodules.sh
GRAAL_DIR=`pwd`

echo
echo Push to GraalBasic repository
git push
cd graal-core
GRAAL_REV=`git rev-parse HEAD`
cd ..

echo 
echo Update and Push SOMns
cd ../SOMns/
./.graal-git-rev
git commit -m "Update graal to ${GRAAL_REV}" .graal-git-rev
git push

echo 
echo Update and Push TruffleSOM
cd ../TruffleSOM
cp $GRAAL_DIR/../SOMns/.graal-git-rev .
git commit -m "Update graal to ${GRAAL_REV}" .graal-git-rev
git push
