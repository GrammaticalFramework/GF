src=../../src
import=-i$(src)/runtime/haskell:$(src)/compiler
cbind=../c-bindings
pythoninc=/usr/include/python2.5
debug= #-optc '-DDEBUG=1'
exdir=../../examples/tutorial/embedded
conf:
	ln -s $(cbind)/PGFFFI.hs
	ln -s $(cbind)/pgf.h
build: gf.so

gf.so:  PGFFFI.hs gfmodule.c
	gf --make  $(exdir)/QueryEng.gf $(exdir)/QuerySpa.gf 
	ghc $(import) --make -fglasgow-exts -O2 -no-hs-main -c $<
	ghc -O2 --make -fglasgow-exts -no-hs-main -optl '-shared' \
	 -optc '-DMODULE=PGFFFI' $(debug) -optc '-I$(pythoninc)' -o $@ $^
clean:
	rm -f *.hi  *.o
	rm -f *_stub.*

superclean: 
	make clean
	rm -f PGFFFI.hs pgf.h Query.pgf
	rm -f gf.so

PyGF.hs: PyGF.hsc
	hsc2hs -I$(pythoninc) $<

mtest: PyGF.hs mtest.c
	ghc $(import) --make -fglasgow-exts -O2 -no-hs-main -c $<
	ghc  -O2 --make -fglasgow-exts -no-hs-main \
	-optc '-DMODULE=PyGF' -optc '-I$(pythoninc)' -o $@ $^