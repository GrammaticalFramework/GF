src=../../src
import=-i$src/runtime/haskell:$src/compiler
cbind=../c-bindings
pythoninc=/usr/include/python2.5

conf:
	ln -s $(cbind)/PGFFFI.hs
	ln -s $(cbind)/pgf.h
Build: gf.so

gf.so:  PGFFFI.hs gfmodule.c
	gf --make ../../examples/tutorial/embedded/QueryEng.gf
	ghc $(import) --make -fglasgow-exts -O2 -no-hs-main -c $<
	ghc -O2 --make -fglasgow-exts -no-hs-main -optl '-shared' \
	 -optc '-DMODULE=PGFFFI' -optc '-I$(pythoninc)' -o $@ $^
clean:
	rm -f *.hi  *.o
	rm -f *_stub.*

superclean: 
	rm -f PGFFFI.hs pgf.h Query.pgf
	rm -f gf.so