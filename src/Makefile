GHMAKE=ghc 
GHCFLAGS=-package lang -package util -fglasgow-exts
GHCFUDFLAG=-package Fudgets
GHCINCLUDE=-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -ifor-ghc -iparsing -iparsers
GHCINCLUDENOFUD=-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -ifor-ghc-nofud -iparsing -iparsers
GHCINCLUDEGFT=-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -ifor-gft -iparsing -iparsers
WINDOWSINCLUDE=-ifor-windows -iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -iparsing -iparsers

all:
	make today ; make ghc
unix:
	make nofud-links ; make ghc
windows:
	make nofud-links ; make justwindows
install-java:
	make javac ; cd ../bin ; ln -s ../src/java ; echo "PLEASE edit GFHOME in bin/jgf2"
ghc: 
	make nofud
fud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) --make GF.hs -o gf2+ ; strip gf2+ ; mv gf2+ ../bin/
gft:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) -itranslate --make translate/GFT.hs -o gft ; strip gft ; mv gft ../bin/
nofud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) --make GF.hs -o gf2 ; strip gf2 ; mv gf2 ../bin/
justwindows:
	$(GHMAKE) $(GHCFLAGS) $(WINDOWSINCLUDE) --make GF.hs -o gf2.exe ; strip gf2.exe ; mv gf2.exe ../bin/
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
	cd java ; javac *.java ; cd ..
help:
	cd util ; runhugs MkHelpFile ; mv HelpFile.hs .. ; cd ..
