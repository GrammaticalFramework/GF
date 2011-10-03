all: src pgf

src:
	runghc MkMini.hs

pgf: src
	gf -make -optimize-pgf MiniGrammar???.gf +RTS -K100M

gf: src
	gf -batch MiniGrammar???.gf
