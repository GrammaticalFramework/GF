
GHMAKE=ghc
GHCI=ghci 
GHCFLAGS=-package lang -package util -fglasgow-exts
GHCOPTFLAGS=-O -package lang -package util -fglasgow-exts
GHCFUDFLAG=-package Fudgets

HUGSINCLUDE    =.:for-hugs:api:source:canonical:cf:grammar:infra:shell:useGrammar:compile:newparsing:trace:
BASICINCLUDE   =-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -inewparsing -iparsers -inotrace
GHCINCLUDE     =-ifor-ghc       $(BASICINCLUDE)
GHCINCLUDENOFUD=-ifor-ghc-nofud $(BASICINCLUDE) 
GHCINCLUDEGFT  =-ifor-gft       $(BASICINCLUDE) 
WINDOWSINCLUDE =-ifor-windows   $(BASICINCLUDE) 

all:
	make today ; make ghc
unix:
	make nofud-links ; make opt
windows:
	make nofud-links ; make justwindows
install-java:
	make javac ; cd ../bin ; ln -s ../src/java ; echo "PLEASE edit GFHOME in bin/jgf2"
opt:
	$(GHMAKE) $(GHCOPTFLAGS) $(GHCINCLUDENOFUD) --make GF.hs -o gf2 ; strip gf2 ; mv gf2 ../bin/

ghc: 
	make nofud
ghci:
	make nofud-links ; make ghci-nofud
fud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) --make GF.hs -o gf2+ ; strip gf2+ ; mv gf2+ ../bin/
gft:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) -itranslate --make translate/GFT.hs -o gft ; strip gft ; mv gft ../bin/
nofud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) --make GF.hs -o gf2 ; strip gf2 ; mv gf2 ../bin/
justwindows:
	$(GHMAKE) $(GHCOPTFLAGS) $(WINDOWSINCLUDE) --make GF.hs -o gf2.exe ; strip gf2.exe ; mv gf2.exe ../bin/
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
	hugs -h10M -P$(HUGSINCLUDE)
ghci-nofud:
	$(GHCI) $(GHCFLAGS) $(GHCINCLUDENOFUD)
today:
	runhugs util/MkToday
javac:
	cd java ; javac *.java ; cd ..
help:
	cd util ; runhugs MkHelpFile ; mv HelpFile.hs .. ; cd ..

# added by peb:
tracing:
	$(GHMAKE) $(GHCFLAGS) -itrace $(GHCINCLUDENOFUD) --make GF.hs -o gf2 ; strip gf2 ; mv gf2 ../bin/

