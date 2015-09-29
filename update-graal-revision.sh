#!/bin/sh
cd graal-compiler
hg pull
hg update
hg id -i > ../graal.revision
