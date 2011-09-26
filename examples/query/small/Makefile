all: pgf treebank

pgf: 
	gf -make -optimize-pgf Query???.gf

treebank:
	gf --run Query.pgf <tests.gfs >treebank.txt



