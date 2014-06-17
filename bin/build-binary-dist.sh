#! /bin/bash

### This script builds a binary distribution tarball of GF from the source
### package that this script is a part of. It assumes that you have installed
### the Haskell Platform, version 2013.2.0.0 or 2012.4.0.0.

os=$(uname)     # Operating system name (e.g. Darwin or Linux)
hw=$(uname -m)  # Hardware name (e.g. i686 or x86_64)

# GF version number:
ver=$(grep -i ^version: gf.cabal | sed -e 's/version://' -e 's/ //g')

destdir=/tmp/gf-binary-dist-$$     # assemble binary dist here
prefix=/usr/local                  # where to install
targz=gf-$ver-bin-$hw-$os.tar.gz   # the final tar file

set -e                             # Stop if an error occurs
set -x                             # print commands before exuting them

## First configure & build the C run-time system
(
cd src/runtime/c
bash setup.sh configure --prefix=$prefix
bash setup.sh build
bash setup.sh install prefix=$destdir$prefix
)

## Now build GF, with C run-time support enabled
cabal install --only-dependencies
cabal configure --prefix=$prefix -fserver -fc-runtime --extra-lib-dirs=$destdir$prefix/lib --extra-include-dirs=$destdir$prefix/include
cabal build
cabal copy --destdir=$destdir

tar -C $destdir/$prefix -zcf $targz .
echo "Created $targz, consider renaming it to something more user friendly"
rm -r $destdir
