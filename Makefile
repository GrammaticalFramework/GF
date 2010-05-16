.PHONY: all build install doc clean sdist

all: build

dist/setup-config: gf.cabal
	chmod u+x lib/src/mkPresent
	chmod u+x lib/src/mkMinimal
	runghc Setup.hs configure

build: dist/setup-config
	runghc Setup.hs build

install:
	runghc Setup.hs install

doc:
	runghc Setup.hs haddock

clean:
	runghc Setup.hs clean

sdist:
	runghc Setup.hs sdist
gf:
	runghc Setup.hs build rgl-none
	strip dist/build/gf/gf

