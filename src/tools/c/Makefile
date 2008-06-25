GHC = ghc
GHCFLAGS =

.PHONY: all gfcc2c clean 

all: gfcc2c

gfcc2c: 
	$(GHC) $(GHCFLAGS) --make -o $@ gfcc2c.hs

bnfc:
	bnfc -gadt -d ../../GF/Canon/GFCC/GFCC.cf
	-rm -f GFCC/Doc.tex GFCC/Skel.hs
	happy -gca GFCC/Par.y
	alex -g GFCC/Lex.x

clean:
	-rm -f gfcc2c
	-rm -f *.o *.hi
	-rm -f GFCC/*.hi GFCC/*.o

bnfcclean: clean
	-rm -f GFCC/*.bak
	-rm -f GFCC/Lex.* GFCC/Par.* GFCC/Layout.* GFCC/Skel.* GFCC/Print.* GFCC/Test.* GFCC/Abs.* GFCC/ComposOp.* GFCC/Test GFCC/ErrM.* GFCC/SharedString.*
	-rmdir -p GFCC/
