#!/bin/sh

echo ""
echo %% Make sure git submodules are up-to-date
echo ""
git submodule update --init --recursive

if [ -d "truffle" ]; then
  cd truffle
  ../mx/mx clean
  cd ..
fi

if [ -d "jvmci" ]; then
  cd jvmci
  ../mx/mx clean
  cd ..
fi

cd graal-compiler
../mx/mx sforceimports

echo ""
echo %% Build Graal Compiler
echo ""
../mx/mx --vm server clean
../mx/mx --vm server build


if [ -d ~/.local ]; then
  JAVA_BUILD=`../mx/mx jdkhome`
  if [ -d ~/.local/graal-core ]; then
    rm -Rf ~/.local/graal-core
  fi
  mv $JAVA_BUILD ~/.local/graal-core
fi