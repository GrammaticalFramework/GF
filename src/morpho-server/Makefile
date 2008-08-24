.PHONY: gf-morpho.fcgi clean

gf-morpho.fcgi: 
	ghc -i.. --make -o $@ MorphoServer.hs
#	cabal configure
#	cabal build
#	cp dist/build/$@/$@ .

clean:
	cabal clean
