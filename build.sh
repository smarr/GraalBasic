#!/bin/sh
set -e

## We got issues with the version check when building from git, so, disable it
export JVMCI_VERSION_CHECK=ignore

echo ""
echo %% Make sure git submodules are up-to-date
echo ""
git submodule update --init --recursive

echo ""
echo %% Clean Truffle
echo ""
cd truffle
../mx/mx clean
cd ..

echo ""
echo %% Build JVMCI-enabled JVM
echo ""
cd graal-jvmci-8
../mx/mx clean
../mx/mx build
export JAVA_HOME=`../mx/mx jdkhome`
cd ..

echo ""
echo %% Build Graal Compiler
echo ""
cd graal-core
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
