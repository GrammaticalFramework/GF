SRCDIR=../src

GHC=ghc
GHCFLAGS=-i$(SRCDIR)


.PHONY: all bnfc bnfctest doc docclean clean bnfcclean distclean

all:
	$(GHC) $(GHCFLAGS) --make -o run_core run_core.hs
	$(GHC) $(GHCFLAGS) --make -o compile_to_core compile_to_core.hs

bnfc: bnfcclean
	cd $(SRCDIR) && bnfc -gadt -d -p Transfer Transfer/Core/Core.cf
	perl -i -pe 's/^import Transfer.Core.ErrM/import Transfer.ErrM/' $(SRCDIR)/Transfer/Core/*.{hs,x,y}
	-rm -f $(SRCDIR)/Transfer/Core/ErrM.hs
	cd $(SRCDIR) && alex -g Transfer/Core/Lex.x
	cd $(SRCDIR) && happy -gca Transfer/Core/Par.y
	cd $(SRCDIR) && bnfc -gadt -d -p Transfer Transfer/Syntax/Syntax.cf
	perl -i -pe 's/^import Transfer.Syntax.ErrM/import Transfer.ErrM/' $(SRCDIR)/Transfer/Syntax/*.{hs,x,y}
	-rm -f $(SRCDIR)/Transfer/Syntax/ErrM.hs
	cd $(SRCDIR) && alex -g Transfer/Syntax/Lex.x
	cd $(SRCDIR) && happy -gca Transfer/Syntax/Par.y

bnfctest:
	ghc $(GHCFLAGS) --make $(SRCDIR)/Transfer/Core/Test.hs -o test_core
	ghc $(GHCFLAGS) --make $(SRCDIR)/Transfer/Syntax/Test.hs -o test_syntax
	ghc $(GHCFLAGS) --make $(SRCDIR)/Transfer/Syntax/ResolveLayout.hs -o test_layout

doc:
	(cd $(SRCDIR)/Transfer/Core/; latex Doc.tex; dvips Doc.dvi -o Doc.ps)
	(cd $(SRCDIR)/Transfer/Syntax/; latex Doc.tex; dvips Doc.dvi -o Doc.ps)

docclean:
	-rm -f $(SRCDIR)/Transfer/Core/*.{log,aux,dvi,ps}
	-rm -f $(SRCDIR)/Transfer/Syntax/*.{log,aux,dvi,ps}

clean:
	-rm -f *.o *.hi
	find $(SRCDIR)/Transfer -name '*.o' -o -name '*.hi' | xargs rm -f
	-rm -f run_core	
	-rm -f compile_to_core
	-rm -f test_core test_syntax test_layout

bnfcclean: 
	-rm -f $(SRCDIR)/Transfer/Core/{Doc,Lex,Par,Layout,Skel,Print,Test,Abs}.*
	-rm -f $(SRCDIR)/Transfer/Syntax/{Doc,Lex,Par,Layout,Skel,Print,Test,Abs}.*

distclean: clean bnfcclean

