all:
	happy -gca ParJS.y
	alex -g LexJS.x

bnfc:
	(cd ../.. && bnfc -p GF.JavaScript GF/JavaScript/JS.cf)
	-rm -f *.bak

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi
	-rm -f DocJS.ps
distclean: clean
	-rm -f DocJS.* LexJS.* ParJS.* LayoutJS.* SkelJS.* PrintJS.* TestJS.* AbsJS.* TestJS ErrM.* SharedString.* JS.dtd XMLJS.* Makefile*

