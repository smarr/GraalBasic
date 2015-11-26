#!/bin/sh
### usage: ./update-graal-revision.sh [hg-id]

echo 
echo Update Graal Compiler
if [ -z "$1" ]; then
  # no argument given, update to latest version
  cd graal-compiler
  hg pull
  hg update
  hg id -i > ../graal.revision
  HG_ID=`hg id -i`
  cd ..
else
  echo "$1\n" > graal.revision
  HG_ID="$1"
fi

echo
echo "Commit update to ${HG_ID}"
git commit -m "Updated graal.revision to ${HG_ID}" graal.revision
