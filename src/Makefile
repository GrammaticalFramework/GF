include config.mk


GHMAKE=$(GHC) --make
GHCFLAGS=-package lang -package util -fglasgow-exts $(CPPFLAGS) $(LDFLAGS)
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

BIN_DIST_DIR=$(DIST_DIR)-$(host)

all: unix

unix: today nofud-links opt

windows: today nofud-links justwindows

install-java: javac
	-rm -f ../bin/java
	ln -s ../src/java ../bin
	@echo "PLEASE edit GFHOME in bin/jgf2"
opt:
	$(GHMAKE) $(GHCOPTFLAGS) $(GHCINCLUDENOFUD) GF.hs -o gf
	strip gf
	mv gf ../bin/

ghc: nofud

ghci: nofud-links ghci-nofud

fud:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) GF.hs -o gf+
	strip gf+
	mv gf+ ../bin/

gft:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) -itranslate translate/GFT.hs -o gft
	strip gft
	mv gft ../bin/

nofud: nofud-links
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) GF.hs -o gf
	strip gf
	mv gf ../bin/

justwindows:
	$(GHMAKE) $(GHCOPTFLAGS) $(WINDOWSINCLUDE) GF.hs -o gf.exe
	strip gf.exe
	mv gf.exe ../bin/

nofud-links:
	mkdir -p for-ghc-nofud
	rm -f for-ghc-nofud/*.hs
	ln -s ../for-ghc/Arch.hs for-ghc-nofud
	ln -s ../for-hugs/ArchEdit.hs for-ghc-nofud

batch: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) GF2.hs -o gf
	strip gf

api: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) API.hs
shell: 
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDE) Shell.hs
clean: 
	-rm -rf */*.o */*.hi *.o *.hi */*.ghi *.ghi *~ */*~
	-rm -f java/*.class

distclean: clean
	-rm -f for-ghc-nofud/*.hs
	-rm -f java/gf-java.jar jgf
	-rm -f util/gfdoc
	-rm -f config.status config.mk config.log
	-rm -f *.tar.gz *.zip
	-rm -rf $(DIST_DIR) $(BIN_DIST_DIR)

hugs:
	hugs -h10M -P$(HUGSINCLUDE)
ghci-nofud:
	$(GHCI) $(GHCFLAGS) $(GHCINCLUDENOFUD)
today:
	util/mktoday.sh
javac:
	javac -target 1.4 -source 1.4 java/*.java

jar: javac
	cd java; jar -cmf manifest.txt gf-java.jar *.class

help:
	cd util ; runhugs MkHelpFile ; mv HelpFile.hs .. ; cd ..

# added by peb:
tracing:
	$(GHMAKE) $(GHCFLAGS) -itrace $(GHCINCLUDENOFUD) GF.hs -o gf
	strip gf
	mv gf ../bin/

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

binary-dist: 
	rm -rf $(BIN_DIST_DIR)
	mkdir $(BIN_DIST_DIR)
	./configure CPPFLAGS="`lib__readline -I` `lib__ncurses -I`" LDFLAGS="`lib__readline -l` `lib__ncurses -l`"
	make unix gfdoc jar
	make prefix=$(BIN_DIST_DIR)/$(prefix) install 
	tar -zcf GF-$(PACKAGE_VERSION)-$(host).tar.gz $(BIN_DIST_DIR)

install-gf:
	$(INSTALL) -d $(bindir)
	$(INSTALL) ../bin/gf $(bindir)

install-gfdoc: 
	$(INSTALL) -d $(bindir)
	$(INSTALL) util/gfdoc $(bindir)

install-editor:
	$(INSTALL) -d $(libdir)/GF-$(PACKAGE_VERSION)
	$(INSTALL) jgf $(bindir)
	$(INSTALL) java/gf-java.jar $(libdir)/GF-$(PACKAGE_VERSION)

install: install-gf install-gfdoc install-editor

gfdoc:
	cd util ; $(GHMAKE) GFDoc.hs -o gfdoc ; cd ..
