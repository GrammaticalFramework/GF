include config.mk


GHMAKE=$(GHC) --make
GHCXMAKE=ghcxmake
GHCFLAGS+= -fglasgow-exts -package fgl
GHCOPTFLAGS=-O2
GHCFUDFLAG=
JAVAFLAGS=-target 1.4 -source 1.4
GFEDITOR=JavaGUI2

DIST_DIR=GF-$(PACKAGE_VERSION)
NOT_IN_DIST= \
	grammars \
	download \
	doc/release2.html \
	src/tools/AlphaConvGF.hs

BIN_DIST_DIR=$(DIST_DIR)-$(host)

GRAMMAR_DIST_DIR=GF-grammars-$(PACKAGE_VERSION)

SNAPSHOT_DIR=GF-$(shell date +%Y%m%d)

MSI_FILE=gf-$(subst .,_,$(PACKAGE_VERSION)).msi

GF_DATA_DIR=$(datadir)/GF-$(PACKAGE_VERSION)

# use the temporary binary file name 'gf-bin' to not clash with directory 'GF' 
# on case insensitive file systems (such as FAT)
GF_EXE=gf$(EXEEXT)
GF_EXE_TMP=gf-bin$(EXEEXT)
GF_DOC_EXE=gfdoc$(EXEEXT)

ifeq ("$(READLINE)","readline")
  GHCFLAGS += -package readline -DUSE_READLINE
endif

ifneq ("$(CPPFLAGS)","")
  GHCFLAGS += -optP'$(CPPFLAGS)'
endif

ifneq ("$(LDFLAGS)","")
  GHCFLAGS += -optl'$(LDFLAGS)'
endif


ifeq ("$(ENABLE_JAVA)", "yes")
  BUILD_JAR=jar
else
  BUILD_JAR=
endif

.PHONY: all unix jar gfdoc windows install install-gf \
        temp install-gfdoc install-editor \
        today help clean windows-msi

all: unix gfdoc $(BUILD_JAR)

unix: today opt

windows: unix

temp: today noopt



build: 
	$(GHMAKE) $(GHCFLAGS) GF.hs -o $(GF_EXE_TMP)
	strip $(GF_EXE_TMP)
	mv $(GF_EXE_TMP) ../bin/$(GF_EXE)

opt: GHCFLAGS += $(GHCOPTFLAGS)
opt: build

noopt: build

ghci: ghci-nofud

fud:
	$(GHCXMAKE) $(GHCFLAGS) $(GHCFUDFLAG) GF.hs -o fgf
	strip fgf
	mv fgf ../bin/

gft:
	$(GHMAKE) $(GHCFLAGS) -itranslate translate/GFT.hs -o gft-bin
	strip gft-bin
	mv gft-bin ../bin/gft

api: 
	$(GHMAKE) $(GHCFLAGS) $(GHCOPTFLAGS) GF/API.hs

shell: 
	$(GHMAKE) $(GHCFLAGS) $(GHCOPTFLAGS) GF/Shell.hs

clean: 
	find . '(' -name '*~' -o -name '*.hi' -o -name '*.ghi' -o -name '*.o' ')' -exec rm -f '{}' ';'
	-rm -f JavaGUI/*.class
	-rm -f $(GFEDITOR)/de/uka/ilkd/key/ocl/gf/*.class
	-rm -f gf.wixobj

distclean: clean
	-rm -f JavaGUI/gf-java.jar jgf
	-rm -f $(GFEDITOR)/gfeditor.jar jgf
	-rm -f tools/$(GF_DOC_EXE)
	-rm -f config.status config.mk config.log
	-rm -f *.tgz *.zip
	-rm -rf $(DIST_DIR) $(BIN_DIST_DIR)
	-rm -rf gf.wxs *.msi

ghci-nofud:
	$(GHCI) $(GHCFLAGS)

today:
	tools/mktoday.sh $(PACKAGE_VERSION)

javac:
	$(JAVAC) $(JAVAFLAGS) -classpath $(GFEDITOR)/jargs-1.0.jar $(GFEDITOR)/de/uka/ilkd/key/ocl/gf/*.java
	$(JAVAC) $(JAVAFLAGS) JavaGUI/*.java

jar: javac
	cd JavaGUI; $(JAR) -cmf manifest.txt gf-java.jar *.class ; cd ..
	cd $(GFEDITOR) ; rm -rf jarcontents ; mkdir jarcontents ; cp -r de ManifestMain.txt ../../LICENSE LICENCE_jargs gf-icon.gif jarcontents ; cat jargs-1.0.jar | (cd jarcontents; jar -x jargs) ; cd jarcontents ; $(JAR) -cmf ManifestMain.txt ../gfeditor.jar  de/uka/ilkd/key/ocl/gf/*.class jargs LICENSE LICENCE_jargs gf-icon.gif ; cd .. ; cd ..

showflags:
	@echo $(GHCFLAGS)

# added by peb:
tracing: GHCFLAGS += -DTRACING
tracing: temp

ghci-trace: GHCFLAGS += -DTRACING
ghci-trace: ghci

#touch-files: 
#	rm -f GF/System/Tracing.{hi,o}
#	touch GF/System/Tracing.hs

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

gfdoc: tools/$(GF_DOC_EXE)

tools/$(GF_DOC_EXE): tools/GFDoc.hs
	$(GHMAKE) $(GHCOPTFLAGS) -o $@ $^

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
	$(TAR) -zcf $(DIST_DIR).tgz $(DIST_DIR)
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
	$(INSTALL) ../bin/$(GF_EXE) tools/$(GF_DOC_EXE) $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 JavaGUI/gf-java.jar $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 $(GFEDITOR)/gfeditor.jar $(BIN_DIST_DIR)
	$(INSTALL) configure config.guess config.sub install-sh $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 config.mk.in jgf.in gfeditor.in $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 ../README ../LICENSE $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 INSTALL.binary $(BIN_DIST_DIR)/INSTALL
	$(INSTALL) -m 0644 Makefile.binary $(BIN_DIST_DIR)/Makefile
	$(TAR) -zcf GF-$(PACKAGE_VERSION)-$(host).tgz $(BIN_DIST_DIR)
	rm -rf $(BIN_DIST_DIR)

grammar-dist:
	-rm -rf $(GRAMMAR_DIST_DIR)
	mkdir $(GRAMMAR_DIST_DIR)
	cvs export -d $(GRAMMAR_DIST_DIR) -rHEAD GF/{lib,examples}
	mv $(GRAMMAR_DIST_DIR)/GF/* $(GRAMMAR_DIST_DIR)
	rmdir $(GRAMMAR_DIST_DIR)/GF
	$(TAR) -zcf $(GRAMMAR_DIST_DIR).tgz $(GRAMMAR_DIST_DIR)
	rm -rf $(GRAMMAR_DIST_DIR)

gf.wxs: config.status gf.wxs.in
	./config.status --file=$@

windows-msi: gf.wxs
	candle -nologo gf.wxs
	light -nologo -o $(MSI_FILE) gf.wixobj

#
# Installation
#

install: install-gf install-gfdoc install-editor

install-gf:
	$(INSTALL) -d $(bindir)
	$(INSTALL) ../bin/$(GF_EXE) $(bindir)

install-gfdoc: 
	$(INSTALL) -d $(bindir)
	$(INSTALL) tools/$(GF_DOC_EXE) $(bindir)

install-editor:
	$(INSTALL) -d $(GF_DATA_DIR)
	$(INSTALL) jgf $(bindir)
	$(INSTALL) -m 0644 JavaGUI/gf-java.jar $(GF_DATA_DIR)
	$(INSTALL) gfeditor $(bindir)
	$(INSTALL) -m 0644 $(GFEDITOR)/gfeditor.jar $(GF_DATA_DIR)

install-java: javac
	-rm -f ../bin/JavaGUI
	ln -s ../src/JavaGUI ../bin
	@echo "PLEASE edit GFHOME in bin/jgf"
	-rm -f ../bin/$(GFEDITOR)
	ln -s ../src/$(GFEDITOR) ../bin
