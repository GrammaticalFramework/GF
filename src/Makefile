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

DIST_DIR=GF-$(PACKAGE_VERSION)
NOT_IN_DIST= \
	from-peb \
	doc/release2.html \
	grammars/resource \
	grammars/aggregation \
	grammars/numerals \
	grammars/ocl \
	grammars/testConversions \
	grammars/timetable \
	src/parsing \
	src/conversions \
	src/util/AlphaConvGF.hs

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
	mkdir -p for-ghc-nofud
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
	-rm -f java/*.class

distclean: clean
	-rm -f for-ghc-nofud/*.hs
	-rm -f java/gf-java.jar jgf2
	-rm -f config.status config.mk config.log
	-rm -f *.tar.gz *.zip

hugs:
	hugs -h10M -P$(HUGSINCLUDE)
ghci-nofud:
	$(GHCI) $(GHCFLAGS) $(GHCINCLUDENOFUD)
today:
	util/mktoday.sh
javac:
	javac java/*.java

jar: javac
	cd java; jar -cmf manifest.txt gf-java.jar *.class

help:
	cd util ; runhugs MkHelpFile ; mv HelpFile.hs .. ; cd ..

# added by peb:
tracing:
	$(GHMAKE) $(GHCFLAGS) -itrace $(GHCINCLUDENOFUD) GF.hs -o gf2
	strip gf2
	mv gf2 ../bin/

dist:
	-rm -rf $(DIST_DIR)
	mkdir $(DIST_DIR)
	cvs export -d $(DIST_DIR) -rHEAD GF2.0
	cd $(DIST_DIR)/src && autoconf && rm -rf autom4te.cache
	find $(DIST_DIR) -name .cvsignore -exec rm -f {} ';'
	cd $(DIST_DIR) && rm -rf $(NOT_IN_DIST)
	tar -zcf $(DIST_DIR).tar.gz $(DIST_DIR)
	zip -r $(DIST_DIR).zip $(DIST_DIR)
	rm -rf $(DIST_DIR)

rpm: dist
	rpmbuild -ta $(DIST_DIR).tar.gz

install:
	$(INSTALL) -d $(bindir)
	$(INSTALL) -d $(libdir)/GF-$(PACKAGE_VERSION)
	$(INSTALL) ../bin/gf2 $(bindir)
	$(INSTALL) jgf2 $(bindir)
	$(INSTALL) java/gf-java.jar $(libdir)/GF-$(PACKAGE_VERSION)
