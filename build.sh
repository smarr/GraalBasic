#!/bin/sh
set -e

echo ""
echo %% Make sure git submodules are up-to-date
echo ""
git submodule update --init --recursive

echo ""
echo %% JAVA_HOME=$JAVA_HOME
echo %% Build JVMCI-enabled JVM
echo ""
cd graal-jvmci-8
../mx/mx clean
../mx/mx build
export JAVA_HOME=`../mx/mx jdkhome`
cd ..

echo ""
echo %% JAVA_HOME=$JAVA_HOME
echo %% Build Graal Compiler
echo ""
cd truffle/compiler
## We got issues with the version check when building from git, so, disable it
export JVMCI_VERSION_CHECK=ignore
../../mx/mx clean
../../mx/mx build

if [ -d ~/.local ]; then
  if [ -d ~/.local/graal-core ]; then
    rm -Rf ~/.local/graal-core
  fi
  ../../mx/mx makegraaljdk ~/.local/graal-core
fi
