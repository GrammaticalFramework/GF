include config.mk


GHMAKE=$(GHC) --make
GHCXMAKE=ghcxmake
GHCFLAGS= -package util -fglasgow-exts $(CPPFLAGS) $(LDFLAGS)
GHCOPTFLAGS=-O2
GHCFUDFLAG=
JAVAFLAGS=-target 1.4 -source 1.4

DIST_DIR=GF-$(PACKAGE_VERSION)
NOT_IN_DIST= \
	grammars \
	download \
	doc/release2.html \
	src/tools/AlphaConvGF.hs

BIN_DIST_DIR=$(DIST_DIR)-$(host)

SNAPSHOT_DIR=GF-$(shell date +%Y%m%d)

.PHONY: all install install-gf install-gfdoc install-editor \
        today help clean

all: unix tools/gfdoc jar

unix: today touch-files opt

windows: today touch-files justwindows

temp: today touch-files noopt



build: 
	$(GHMAKE) $(GHCFLAGS) GF.hs -o gf-bin
	strip gf-bin
	mv gf-bin ../bin/gf

opt: GHCFLAGS += $(GHCOPTFLAGS)
opt: build

noopt: build

ghci: touch-files ghci-nofud

fud:
	$(GHCXMAKE) $(GHCFLAGS) $(GHCFUDFLAG) GF.hs -o fgf
	strip fgf
	mv fgf ../bin/

gft:
	$(GHMAKE) $(GHCFLAGS) -itranslate translate/GFT.hs -o gft-bin
	strip gft-bin
	mv gft-bin ../bin/gft

justwindows:
	$(GHMAKE) $(GHCOPTFLAGS) GF.hs -o gf.exe
	strip gf.exe
	mv gf.exe ../bin/

api: 
	$(GHMAKE) $(GHCFLAGS) GF/API.hs

shell: 
	$(GHMAKE) $(GHCFLAGS) GF/Shell.hs

clean: 
	-rm -rf */*.o */*.hi *.o *.hi */*.ghi *.ghi *~ */*~
	-rm -f GF/*.{o,hi,ghi} GF/*/*.{o,hi,ghi} GF/*/*/*.{o,hi,ghi}
	-rm -f JavaGUI/*.class

distclean: clean
	-rm -f JavaGUI/gf-java.jar jgf
	-rm -f tools/gfdoc
	-rm -f config.status config.mk config.log
	-rm -f *.tgz *.zip
	-rm -rf $(DIST_DIR) $(BIN_DIST_DIR)

ghci-nofud:
	$(GHCI) $(GHCFLAGS)

today:
	tools/mktoday.sh $(PACKAGE_VERSION)

javac:
	$(JAVAC) $(JAVAFLAGS) JavaGUI/*.java

jar: javac
	cd JavaGUI; $(JAR) -cmf manifest.txt gf-java.jar *.class



# added by peb:
tracing: GHCFLAGS += -DTRACING
tracing: temp

ghci-trace: GHCFLAGS += -DTRACING
ghci-trace: ghci

touch-files: 
	rm -f GF/System/Tracing.{hi,o}
	touch GF/System/Tracing.hs

# profiling
prof: GHCOPTFLAGS += -prof -auto-all -auto-dicts
prof: all



#
# Help file
#

tools/MkHelpFile: tools/MkHelpFile.hs
	$(GHMAKE) -o $@ $^

help: GF/Shell/HelpFile.hs

GF/Shell/HelpFile.hs: tools/MkHelpFile HelpFile
	tools/MkHelpFile

#
# Tools
#

tools/gfdoc: tools/GFDoc.hs
	$(GHMAKE) -o $@ $^

#
# Distribution
#

dist:
	-rm -rf $(DIST_DIR)
	mkdir $(DIST_DIR)
	cvs export -d $(DIST_DIR) -rHEAD GF
	cd $(DIST_DIR)/src && autoconf && rm -rf autom4te.cache
	find $(DIST_DIR) -name .cvsignore -exec rm -f {} ';'
#	cd $(DIST_DIR)/grammars && sh mkLib.sh
	cd $(DIST_DIR) && rm -rf $(NOT_IN_DIST)
	gtar -zcf $(DIST_DIR).tgz $(DIST_DIR)
	rm -rf $(DIST_DIR)

snapshot: DIST_DIR=$(SNAPSHOT_DIR)
snapshot: dist

rpm: dist
	rpmbuild -ta $(DIST_DIR).tgz


binary-dist: 
	rm -rf $(BIN_DIST_DIR)
	mkdir $(BIN_DIST_DIR)
	./configure --host="$(host)" \
                    CPPFLAGS="`lib__readline -I` `lib__ncurses -I`" \
                    LDFLAGS="`lib__readline -l` `lib__ncurses -l`"
	$(MAKE) all
	$(INSTALL) ../bin/gf tools/gfdoc $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 JavaGUI/gf-java.jar $(BIN_DIST_DIR)
	$(INSTALL) configure config.guess config.sub install-sh $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 config.mk.in jgf.in $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 ../README ../LICENSE $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 INSTALL.binary $(BIN_DIST_DIR)/INSTALL
	$(INSTALL) -m 0644 Makefile.binary $(BIN_DIST_DIR)/Makefile
	gtar -zcf GF-$(PACKAGE_VERSION)-$(host).tgz $(BIN_DIST_DIR)
	rm -rf $(BIN_DIST_DIR)

#
# Installation
#

install: install-gf install-gfdoc install-editor

install-gf:
	$(INSTALL) -d $(bindir)
	$(INSTALL) ../bin/gf $(bindir)

install-gfdoc: 
	$(INSTALL) -d $(bindir)
	$(INSTALL) tools/gfdoc $(bindir)

install-editor:
	$(INSTALL) -d $(datadir)/GF-$(PACKAGE_VERSION)
	$(INSTALL) jgf $(bindir)
	$(INSTALL) -m 0644 JavaGUI/gf-java.jar $(datadir)/GF-$(PACKAGE_VERSION)

install-java: javac
	-rm -f ../bin/JavaGUI
	ln -s ../src/JavaGUI ../bin
	@echo "PLEASE edit GFHOME in bin/jgf"
