GHMAKE=ghc 
GHCFLAGS=-package lang -package util
GHCFUDFLAG=-package Fudgets
GHCINCLUDE=-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -ifor-ghc -iparsing

all:
	make today ; make ghc
ghc: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) --make GF.hs -o gf2+ ; strip gf2+ ; mv gf2+ ../bin/
batch: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) --make GF2.hs -o gf2 ; strip gf2
api: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) --make API.hs
shell: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) --make Shell.hs
clean: 
	rm -rf */*.o */*.hi *.o *.hi */*.ghi *.ghi *~ */*~
hugs:
	hugs -P.:for-hugs:api:source:canonical:cf:grammar:infra:shell:useGrammar:compile:parsing: GF
today:
	runhugs util/MkToday
javac:
	cd java ; javac GFEditor.java ; cd ..
