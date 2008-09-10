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
        today help clean windows-msi dist gfc

all: unix gfc lib

static: GHCFLAGS += -optl-static
static: unix


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

clean: 
	find . '(' -name '*~' -o -name '*.hi' -o -name '*.ghi' -o -name '*.o' ')' -exec rm -f '{}' ';'
	-rm -f gf.wixobj
	-rm -f ../bin/$(GF_EXE)
	$(MAKE) -C tools/c clean
	$(MAKE) -C ../lib/c clean
	-rm -f ../bin/gfcc2c

distclean: clean
	-rm -f tools/$(GF_DOC_EXE)
	-rm -f config.status config.mk config.log
	-rm -f *.tgz *.zip
	-rm -rf $(DIST_DIR) $(BIN_DIST_DIR)
	-rm -rf gf.wxs *.msi

today:
	echo 'module Paths_gf (version, getDataDir) where' > Paths_gf.hs
	echo 'import Data.Version' >> Paths_gf.hs
	echo '{-# NOINLINE version #-}' >> Paths_gf.hs
	echo 'version :: Version' >> Paths_gf.hs
	echo 'version = Version {versionBranch = [3,0], versionTags = ["beta2"]}' >> Paths_gf.hs
	echo 'getDataDir = return "$(GF_DATA_DIR)" :: IO FilePath' >> Paths_gf.hs


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

gfc: gf
	echo GFC!
	cp -f gfc ../bin/
	chmod a+x ../bin/gfc

gfcc2c:
	$(MAKE) -C tools/c
	$(MAKE) -C ../lib/c
	mv tools/c/gfcc2c ../bin

#
# Resource grammars
#

lib:
	$(MAKE) -C ../lib/resource clean all

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
	$(MAKE) all gfdoc
	$(INSTALL) ../bin/$(GF_EXE) tools/$(GF_DOC_EXE) $(BIN_DIST_DIR)
	$(INSTALL) configure config.guess config.sub install-sh $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 ../README ../LICENSE $(BIN_DIST_DIR)
	$(INSTALL) -m 0644 INSTALL.binary $(BIN_DIST_DIR)/INSTALL
	$(INSTALL) -m 0644 Makefile.binary $(BIN_DIST_DIR)/Makefile
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
