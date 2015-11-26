#!/bin/sh
# usage: update-and-build.sh [hg-id]
#./update-graal-revision.sh "$1"
GRAAL_DIR=`pwd`

git push
HG_ID=`cat graal.revision`

cd ../SOMns/
./.graal-git-rev
git commit -m "Update graal to ${HG_ID}" .graal-git-rev
git push

cd ../TruffleSOM
cp $GRAAL_DIR/../SOMns/.graal-git-rev .
git commit -m "Update graal to ${HG_ID}" .graal-git-rev
git push
