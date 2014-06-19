.PHONY: all build install doc clean gf # sdist

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
# (Tested on Ubuntu 14.04. You need to install dpkg-dev & debhelper.)
deb:
	dpkg-buildpackage -b
