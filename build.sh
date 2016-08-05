#!/bin/sh

echo ""
echo %% Make sure git submodules are up-to-date
echo ""
git submodule update --init --recursive

cd truffle
../mx/mx clean
cd ..

cd graal-jvmci-8
../mx/mx clean
export JAVA_HOME=`../mx/mx jdkhome`
cd ..

cd graal-core

echo ""
echo %% Build Graal Compiler
echo ""
../mx/mx clean
../mx/mx build

echo ""
echo %% Deploy Graal Into JVMCI Built
cp mxbuild/dists/graal.jar $JAVA_HOME/jre/lib/jvmci/

if [ -d ~/.local ]; then
  if [ -d ~/.local/graal-core ]; then
    rm -Rf ~/.local/graal-core
  fi
  mv $JAVA_HOME ~/.local/graal-core
fi
