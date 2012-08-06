.PHONY: all build install doc clean gf # sdist

all: build

dist/setup-config: gf.cabal Setup.hs
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
