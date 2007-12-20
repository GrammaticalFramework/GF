include config.mk


GHMAKE=$(GHC) --make
GHCXMAKE=ghcxmake
GHCFLAGS+= -fglasgow-exts
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

GRAMMAR_PACKAGE_VERSION=$(shell date +%Y%m%d)
GRAMMAR_DIST_DIR=gf-grammars-$(GRAMMAR_PACKAGE_VERSION)

MSI_FILE=gf-$(subst .,_,$(PACKAGE_VERSION)).msi

GF_DATA_DIR=$(datadir)/GF-$(PACKAGE_VERSION)
GF_LIB_DIR=$(GF_DATA_DIR)/lib

EMBED = GF/Embed/TemplateApp

# use the temporary binary file name 'gf-bin' to not clash with directory 'GF' 
# on case insensitive file systems (such as FAT)
GF_EXE=gf$(EXEEXT)
GF_EXE_TMP=gf-bin$(EXEEXT)
GF_DOC_EXE=gfdoc$(EXEEXT)
GF3_EXE=gf3$(EXEEXT)
TESTGF3_EXE=testgf3$(EXEEXT)


ifeq ("$(READLINE)","readline")
  GHCFLAGS += -package readline -DUSE_READLINE
endif

ifneq ("$(CPPFLAGS)","")
  GHCFLAGS += $(addprefix -optP, $(CPPFLAGS))
endif

ifneq ("$(LDFLAGS)","")
  GHCFLAGS += $(addprefix -optl, $(LDFLAGS))
endif

ifeq ("$(INTERRUPT)","yes")
  GHCFLAGS += -DUSE_INTERRUPT
endif

ifeq ("$(ATK)","yes")
  GHCFLAGS += -DUSE_ATK
endif

ifeq ("$(ENABLE_JAVA)", "yes")
  BUILD_JAR=jar
else
  BUILD_JAR=
endif

.PHONY: all unix jar tags gfdoc windows install install-gf \
        lib temp install-gfdoc install-editor \
        today help clean windows-msi dist

all: unix gfdoc $(BUILD_JAR) lib

gf: unix

unix: today opt

windows: unix

temp: today noopt



build: 
	$(GHMAKE) $(GHCFLAGS) GF.hs -o $(GF_EXE_TMP)
	strip $(GF_EXE_TMP)
	mv $(GF_EXE_TMP) ../bin/$(GF_EXE)

opt: GHCFLAGS += $(GHCOPTFLAGS)
opt: build

embed: GHCFLAGS += $(GHCOPTFLAGS)
embed:
	$(GHMAKE) $(GHCFLAGS) $(EMBED) -o $(EMBED)
	strip $(EMBED)

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
	-rm -f ../bin/$(GF_EXE)
	$(MAKE) -C tools/c clean
	$(MAKE) -C ../lib/c clean
	-rm -f ../bin/gfcc2c

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
	echo 'module GF.Today (today,version,libdir) where' > GF/Today.hs
	echo '{-# NOINLINE today #-}' >> GF/Today.hs
	echo 'today :: String' >> GF/Today.hs
	echo 'today = "'`date`'"' >> GF/Today.hs
	echo '{-# NOINLINE version #-}' >> GF/Today.hs
	echo 'version :: String' >> GF/Today.hs
	echo 'version = "'$(PACKAGE_VERSION)'"' >> GF/Today.hs
	echo '{-# NOINLINE libdir #-}' >> GF/Today.hs
	echo 'libdir :: String' >> GF/Today.hs
	echo 'libdir = "'$(GF_LIB_DIR)'"' >> GF/Today.hs

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

tags:
	find GF Transfer -name '*.hs' | xargs hasktags

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

gfc: gf3
	cp -f gfc ../bin/
	chmod a+x ../bin/gfc

gfi: gf3

gf3:
	$(GHMAKE) $(GHCOPTFLAGS) -o gf3 GF/Devel/GF.hs
	strip $(GF3_EXE)
	mv $(GF3_EXE) ../bin/

testgf3:
	$(GHMAKE) $(GHCOPTFLAGS) -o testgf3 GF/Devel/TestGF3.hs
	strip $(TESTGF3_EXE)
	mv $(TESTGF3_EXE) ../bin/

gfcc2c:
	$(MAKE) -C tools/c
	$(MAKE) -C ../lib/c
	mv tools/c/gfcc2c ../bin

#
# Resource grammars
#

lib:
	$(MAKE) -C ../lib/resource clean new

#
# Distribution
#

dist:
	-rm -rf $(DIST_DIR)
	darcs dist --dist-name=$(DIST_DIR)
	tar -zxf ../$(DIST_DIR).tar.gz
	rm ../$(DIST_DIR).tar.gz
	cd $(DIST_DIR)/src && perl -pi -e "s/^AC_INIT\(\[GF\],\[[^\]]*\]/AC_INIT([GF],[$(PACKAGE_VERSION)]/" configure.ac
	cd $(DIST_DIR)/src && autoconf && rm -rf autom4te.cache
#	cd $(DIST_DIR)/grammars && sh mkLib.sh
	cd $(DIST_DIR) && rm -rf $(NOT_IN_DIST)
	$(TAR) -zcf $(DIST_DIR).tgz $(DIST_DIR)
	rm -rf $(DIST_DIR)

snapshot: PACKAGE_VERSION=$(shell date +%Y%m%d)
snapshot: DIST_DIR=GF-$(PACKAGE_VERSION)
snapshot: dist

rpm: dist
	rpmbuild -ta $(DIST_DIR).tgz


binary-dist: 
	rm -rf $(BIN_DIST_DIR)
	mkdir $(BIN_DIST_DIR)
	mkdir $(BIN_DIST_DIR)/lib
	./configure --host="$(host)" --build="$(build)"
	$(MAKE) all
	$(INSTALL) ../bin/$(GF_EXE) tools/$(GF_DOC_EXE) $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 JavaGUI/gf-java.jar $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 $(GFEDITOR)/gfeditor.jar $(BIN_DIST_DIR)
	$(INSTALL) configure config.guess config.sub install-sh $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 config.mk.in jgf.in gfeditor.in $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 ../README ../LICENSE $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 INSTALL.binary $(BIN_DIST_DIR)/INSTALL
	$(INSTALL) -m 0644 Makefile.binary $(BIN_DIST_DIR)/Makefile
	$(MAKE) lib
	$(TAR) -C $(BIN_DIST_DIR)/lib -zxf ../lib/compiled.tgz
	$(TAR) -zcf GF-$(PACKAGE_VERSION)-$(host).tgz $(BIN_DIST_DIR)
	rm -rf $(BIN_DIST_DIR)

grammar-dist:
	-rm -rf $(GRAMMAR_DIST_DIR)
	mkdir $(GRAMMAR_DIST_DIR)
	cp -r ../_darcs/current/{lib,examples} $(GRAMMAR_DIST_DIR)
	$(MAKE) GF_LIB_PATH=.. -C $(GRAMMAR_DIST_DIR)/lib/resource-1.0 show-path prelude present alltenses mathematical api multimodal langs
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

install: install-gf install-gfdoc install-lib install-editor

install-gf:
	$(INSTALL) -d $(bindir)
	$(INSTALL) ../bin/$(GF_EXE) $(bindir)

install-gf3:
	$(INSTALL) -d $(bindir)
	$(INSTALL) ../bin/$(GF3_EXE) $(bindir)
	$(INSTALL) ../bin/gfc $(bindir)

install-gfdoc: 
	$(INSTALL) -d $(bindir)
	$(INSTALL) tools/$(GF_DOC_EXE) $(bindir)

install-lib:
	$(INSTALL) -d $(GF_LIB_DIR)
	$(TAR) -C $(GF_LIB_DIR) -zxf ../lib/compiled.tgz

install-editor:
	$(INSTALL) -d $(GF_DATA_DIR)
	$(INSTALL) jgf $(bindir)
	$(INSTALL) -m 0644 JavaGUI/gf-java.jar $(GF_DATA_DIR)
	$(INSTALL) gfeditor $(bindir)
	$(INSTALL) -m 0644 $(GFEDITOR)/gfeditor.jar $(GF_DATA_DIR)

install-java:
	-rm -f ../bin/JavaGUI
	ln -s ../src/JavaGUI ../bin
	@echo "PLEASE set GFHOME and GF_LIB_PATH in your environment"
	-rm -f ../bin/$(GFEDITOR)
	ln -s ../src/$(GFEDITOR) ../bin
