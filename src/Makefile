include config.mk


GHMAKE=$(GHC) --make
GHCFLAGS=-package lang -package util -fglasgow-exts
GHCOPTFLAGS=-O $(GHCFLAGS)
GHCFUDFLAG=-package Fudgets

HUGSINCLUDE    =.:for-hugs:api:source:canonical:cf:grammar:infra:shell:useGrammar:compile:newparsing:trace:
BASICINCLUDE   =-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -inewparsing -iparsers -inotrace
GHCINCLUDE     =-ifor-ghc       $(BASICINCLUDE)
GHCINCLUDENOFUD=-ifor-ghc-nofud $(BASICINCLUDE) 
GHCINCLUDEGFT  =-ifor-gft       $(BASICINCLUDE) 
WINDOWSINCLUDE =-ifor-windows   $(BASICINCLUDE) 

all: unix

unix: today nofud-links opt

windows: today nofud-links justwindows

install-java: javac
	-rm -f ../bin/java
	ln -s ../src/java ../bin
	@echo "PLEASE edit GFHOME in bin/jgf2"
opt:
	$(GHMAKE) $(GHCOPTFLAGS) $(GHCINCLUDENOFUD) GF.hs -o gf2
	strip gf2
	mv gf2 ../bin/

ghc: nofud

ghci: nofud-links ghci-nofud

fud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) GF.hs -o gf2+
	strip gf2+
	mv gf2+ ../bin/

gft:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) -itranslate translate/GFT.hs -o gft
	strip gft
	mv gft ../bin/

nofud: nofud-links
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) GF.hs -o gf2
	strip gf2
	mv gf2 ../bin/

justwindows:
	$(GHMAKE) $(GHCOPTFLAGS) $(WINDOWSINCLUDE) GF.hs -o gf2.exe
	strip gf2.exe
	mv gf2.exe ../bin/

nofud-links:
	rm -f for-ghc-nofud/*.hs
	ln -s ../for-ghc/Arch.hs for-ghc-nofud
	ln -s ../for-hugs/ArchEdit.hs for-ghc-nofud

batch: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) GF2.hs -o gf2
	strip gf2

api: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) API.hs
shell: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) Shell.hs
clean: 
	-rm -rf */*.o */*.hi *.o *.hi */*.ghi *.ghi *~ */*~

distclean: clean
	-rm -f for-ghc-nofud/*.hs
	-rm -f config.status config.mk config.log

hugs:
	hugs -h10M -P$(HUGSINCLUDE)
ghci-nofud:
	$(GHCI) $(GHCFLAGS) $(GHCINCLUDENOFUD)
today:
	util/mktoday.sh
javac:
	javac java/*.java
help:
	cd util ; runhugs MkHelpFile ; mv HelpFile.hs .. ; cd ..

# added by peb:
tracing:
	$(GHMAKE) $(GHCFLAGS) -itrace $(GHCINCLUDENOFUD) GF.hs -o gf2
	strip gf2
	mv gf2 ../bin/

install:
	$(INSTALL) ../bin/gf2 $(bindir)
