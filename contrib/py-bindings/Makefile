src=../../src
import=-i$(src)/runtime/haskell:$(src)/compiler
cbind=../c-bindings
pythoninc=/usr/include/python2.6
debug= #-optc '-DDEBUG=1'
exdir=../../examples/tutorial/embedded

build: gf.so

test:
	python test.py

gf.so:  PyGF.hs gfmodule.c Query.pgf
	ghc $(import) --make -fglasgow-exts -O2 -no-hs-main -c $<
	ghc -O2 --make -fglasgow-exts -no-hs-main -optl '-shared' \
	 -optc '-DMODULE=$(basename $<)' $(debug) -optc '-I$(pythoninc)' -o $@ \
	$(filter-out %.pgf, $^)



clean:
	rm -f *.hi  *.o
	rm -f *_stub.*
	rm -f PyGF.hs

superclean: 
	make clean
	rm -f Query.pgf
	rm -f gf.so
	rm -f mtest

PyGF.hs: PyGF.hsc
	hsc2hs -I$(pythoninc) $<

Query.pgf:
	gf --make  $(exdir)/QueryEng.gf $(exdir)/QuerySpa.gf 
