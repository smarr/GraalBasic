#!/bin/sh

REV=`cat graal.revision`

if [ ! -d "mx" ]; then
  echo ""
  echo %% Load MX
  echo ""
  hg clone https://bitbucket.org/allr/mx
else
  echo ""
  echo %% Update MX
  echo ""
  cd mx
  hg pull
  hg update
  cd ..
fi

if [ ! -d "graal-compiler" ]; then
  echo ""
  echo %% Clone Graal Compiler
  echo ""
  hg clone http://lafo.ssw.uni-linz.ac.at/hg/graal-compiler/
fi

if [ ! -d "truffle" ]; then
  cd truffle
  ../mx/mx clean
  cd ..
fi

if [ ! -d "jvmci" ]; then
  cd jvmci
  ../mx/mx clean
  cd ..
fi

cd graal-compiler
hg pull
hg update -r $REV

echo ""
echo %% Build Graal Compiler
echo ""
../mx/mx --vm server clean
../mx/mx --vm server build

