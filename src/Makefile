GHMAKE=ghc 
GHCFLAGS=-package lang -package util -fglasgow-exts
GHCFUDFLAG=-package Fudgets
GHCINCLUDE=-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -ifor-ghc -iparsing -iparsers
GHCINCLUDENOFUD=-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -ifor-ghc-nofud -iparsing -iparsers
WINDOWSINCLUDE=-ifor-windows -iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -iparsing -iparsers

all:
	make today ; make ghc
ghc: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) --make GF.hs -o gf2+ ; strip gf2+ ; mv gf2+ ../bin/
nofud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) --make GF.hs -o gf2n ; strip gf2n ; mv gf2n ../bin/
windows:
	$(GHMAKE) $(GHCFLAGS) $(WINDOWSINCLUDE) --make GF.hs -o gf2w ; strip gf2w.exe ; mv gf2w.exe ../bin/
nofud-links:
	cd for-ghc-nofud ; rm -f *.hs ; ln -s ../for-ghc/Arch.hs ; ln -s ../for-hugs/ArchEdit.hs ; cd ..
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
