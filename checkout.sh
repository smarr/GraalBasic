#!/bin/sh

REV=`cat graal.revision`

if [ ! -d "mx" ]; then
  echo Load MX
  hg clone https://bitbucket.org/allr/mx
else
  echo Update MX
  cd mx
  hg pull
  hg update
  cd ..
fi

if [ ! -d "graal-compiler" ]; then
  echo Clone Graal Compiler
  hg clone http://lafo.ssw.uni-linz.ac.at/hg/graal-compiler/
fi

cd graal-compiler
hg pull
hg update -r $REV

echo Build Graal Compiler
../mx/mx --vm server build

