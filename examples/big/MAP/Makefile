all: 
	make big
	make gf
	mv Big*.gf ..
gf:
	./mkBig

big:
	ghc --make MkBig -o mkBig
parser:
	happy -gca ParLisp.y
	alex -g LexLisp.x
	latex DocLisp.tex; dvips DocLisp.dvi -o DocLisp.ps
	ghc --make TestLisp.hs -o TestLisp
clean:
	-rm -f *.log *.aux *.hi *.o *.dvi
	-rm -f DocLisp.ps
distclean: clean
	-rm -f DocLisp.* LexLisp.* ParLisp.* LayoutLisp.* SkelLisp.* PrintLisp.* TestLisp.* AbsLisp.* TestLisp ErrM.* SharedString.* Lisp.dtd XMLLisp.* Makefile*

