include config.mk


GHMAKE=$(GHC) --make
GHCXMAKE=ghcxmake
GHCFLAGS=-package lang -package util -fglasgow-exts $(CPPFLAGS) $(LDFLAGS)
GHCOPTFLAGS=-O $(GHCFLAGS)
GHCFUDFLAG=
JAVAFLAGS=-target 1.4 -source 1.4

HUGSINCLUDE    =.:for-hugs:api:source:canonical:cf:grammar:infra:shell:useGrammar:compile:newparsing:trace:
BASICINCLUDE   =-iapi -icompile -igrammar -iinfra -ishell -isource -icanonical -iuseGrammar -icf -inewparsing -iparsers -inotrace -icfgm -ispeech
GHCINCLUDE     =-ifor-ghc       $(BASICINCLUDE)
GHCINCLUDENOFUD=-ifor-ghc-nofud $(BASICINCLUDE) 
GHCINCLUDEGFT  =-ifor-gft       $(BASICINCLUDE) 
WINDOWSINCLUDE =-ifor-windows   $(BASICINCLUDE) 

DIST_DIR=GF-$(PACKAGE_VERSION)
NOT_IN_DIST= \
	from-peb \
	grammars \
	doc/release2.html \
	src/parsing \
	src/conversions \
	src/util/AlphaConvGF.hs

BIN_DIST_DIR=$(DIST_DIR)-$(host)

all: unix

temp: today noopt

unix: today nofud-links opt

windows: today nofud-links justwindows

install-java: javac
	-rm -f ../bin/java
	ln -s ../src/java ../bin
	@echo "PLEASE edit GFHOME in bin/jgf"
opt:
	$(GHMAKE) $(GHCOPTFLAGS) $(GHCINCLUDENOFUD) GF.hs -o gf
	strip gf
	mv gf ../bin/
noopt:
	$(GHMAKE) $(GHCFLAGS) $(GHCINCLUDENOFUD) GF.hs -o gf
	strip gf
	mv gf ../bin/

ghc: nofud

ghci: nofud-links ghci-nofud

fud:
	$(GHCXMAKE) $(GHCFLAGS) $(GHCINCLUDE) $(GHCFUDFLAG) GF.hs -o fgf
	strip fgf
	mv fgf ../bin/

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
	-rm -f *.tgz *.zip
	-rm -rf $(DIST_DIR) $(BIN_DIST_DIR)

hugs:
	hugs -h10M -P$(HUGSINCLUDE)
ghci-nofud:
	$(GHCI) $(GHCFLAGS) $(GHCINCLUDENOFUD)
today:
	util/mktoday.sh
javac:
	$(JAVAC) $(JAVAFLAGS) java/*.java

jar: javac
	cd java; $(JAR) -cmf manifest.txt gf-java.jar *.class

help:
	cd util ; runhugs MkHelpFile ; mv HelpFile.hs .. ; cd ..

# added by peb:
tracing:
	$(GHMAKE) $(GHCFLAGS) -itrace $(GHCINCLUDENOFUD) GF.hs -o gf
	strip gf
	mv gf ../bin/

prof: GHCOPTFLAGS += -prof -auto-all -auto-dicts
prof: all

lib:
	cd ../grammars
	sh mkLib.sh

dist:
	-rm -rf $(DIST_DIR)
	mkdir $(DIST_DIR)
	cvs export -d $(DIST_DIR) -rHEAD GF2.1
	cd $(DIST_DIR)/src && autoconf && rm -rf autom4te.cache
	find $(DIST_DIR) -name .cvsignore -exec rm -f {} ';'
	cd $(DIST_DIR)/grammars && sh mkLib.sh
	cd $(DIST_DIR) && rm -rf $(NOT_IN_DIST)
	gtar -zcf $(DIST_DIR).tgz $(DIST_DIR)
	rm -rf $(DIST_DIR)

rpm: dist
	rpmbuild -ta $(DIST_DIR).tgz

binary-dist: 
	rm -rf $(BIN_DIST_DIR)
	mkdir $(BIN_DIST_DIR)
	./configure --host="$(host)" CPPFLAGS="`lib__readline -I` `lib__ncurses -I`" LDFLAGS="`lib__readline -l` `lib__ncurses -l`"
	make unix gfdoc jar
	$(INSTALL) ../bin/gf util/gfdoc $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 java/gf-java.jar $(BIN_DIST_DIR)
	$(INSTALL) configure config.guess config.sub install-sh $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 config.mk.in jgf.in $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 ../README ../LICENSE $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 INSTALL.binary $(BIN_DIST_DIR)/INSTALL
	$(INSTALL) -m 0644 Makefile.binary $(BIN_DIST_DIR)/Makefile
	gtar -zcf GF-$(PACKAGE_VERSION)-$(host).tgz $(BIN_DIST_DIR)
	rm -rf $(BIN_DIST_DIR)

install-gf:
	$(INSTALL) -d $(bindir)
	$(INSTALL) ../bin/gf $(bindir)

install-gfdoc: 
	$(INSTALL) -d $(bindir)
	$(INSTALL) util/gfdoc $(bindir)

install-editor:
	$(INSTALL) -d $(datadir)/GF-$(PACKAGE_VERSION)
	$(INSTALL) jgf $(bindir)
	$(INSTALL) -m 0644 java/gf-java.jar $(datadir)/GF-$(PACKAGE_VERSION)

install: install-gf install-gfdoc install-editor

gfdoc:
	cd util ; $(GHMAKE) GFDoc.hs -o gfdoc ; cd ..
