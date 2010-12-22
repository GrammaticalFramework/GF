#! /bin/bash

### This script builds a binary distribution of GF from the source package
### that this script is a part of. It also assumes that you have installed
### the Haskell Platform, version 2010.1.0.0 or 2010.2.0.0

destdir=/tmp/gf-build-binary-dist  # assemble binary dist here
targz=gf-bin.tar.gz                # the final tar file, should be renamed 
langs=""                           # which languages?
#langs="langs=-Pol" # temporary problem with Polish, omit it

set -e                             # Stop if an error occurs
set -x                             # print commands before exuting them

cabal install    # gf needs to be installed before building gf-server below

runhaskell Setup.hs configure --user --prefix /usr/local
runhaskell Setup.hs build $langs
runhaskell Setup.hs copy --destdir=$destdir $langs

(
cd src/server

## If you don't already have the packages gf-server depends on, this is
## the easiest way to install them:
#cabal install

runhaskell Setup.hs configure --user --prefix /usr/local
runhaskell Setup.hs build
runhaskell Setup.hs copy --destdir=$destdir
)
tar -C $destdir -zcf $targz .
echo "Created $targz, rename it to something more informative"
rm -r $destdir
