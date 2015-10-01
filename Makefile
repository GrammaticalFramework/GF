.PHONY: all build install doc clean gf sdist

# This gets the numeric part of the version from the cabal file
VERSION=$(shell sed -ne "s/^version: *\([0-9.]*\).*/\1/p" gf.cabal)

all: build

dist/setup-config: gf.cabal Setup.hs WebSetup.hs
	cabal configure

build: dist/setup-config
	cabal build

install:
	cabal copy
	cabal register

doc:
	cabal haddock

clean:
	cabal clean

#sdist:
#	cabal sdist

gf:
	cabal build rgl-none
	strip dist/build/gf/gf

html::
	bash bin/update_html

# Make a debian package. First add a suitable entry with the correct GF version
# number to the top of debian/changelog.
# (Tested on Ubuntu 15.04. You need to install dpkg-dev & debhelper.)
deb:
	dpkg-buildpackage -b

# Make an OS X Installer package
pkg:
	FMT=pkg bash bin/build-binary-dist.sh

# Make a binary tar distribution
bintar:
	bash bin/build-binary-dist.sh

# Make a source tar.gz distribution using darcs to make sure that everything
# is included. We put the distribution in dist/ so it is removed on
# `make clean`
sdist:
	test -d dist || mkdir dist
	darcs dist -d dist/gf-${VERSION}
