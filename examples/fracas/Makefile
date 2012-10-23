
VERSION = 0.2

BANK = FraCaSBank
BUILD-FORMATS = xml pl
LANGUAGES = Original Eng Swe

ZIPFILE = $(BANK)-$(VERSION).zip
FILES-TO-ZIP = Makefile *.* src/*.* doc/*.* build/*.*

GF-FILES = $(wildcard src/*.gf)

.PHONY: build clean distclean dist

.DELETE_ON_ERROR:

build: $(BUILD-FORMATS:%=build/$(BANK).%)

clean:
	rm -f src/*.gfo src/*.pyc .DS_Store */.DS_Store FraCaS.pgf $(BANK)I.hs

distclean: clean
	rm -f build/$(BANK).*
	rm -f dist/$(ZIPFILE)

dist: build clean
	mkdir -p dist
	rm -f dist/$(ZIPFILE)
	zip dist/$(ZIPFILE) $(FILES-TO-ZIP)

build/$(BANK).%: $(GF-FILES)
	python build_fracasbank.py $* src/$(BANK)I.gf $(LANGUAGES:%=src/$(BANK)%.gf) > $@

#### HTML generation:

build/$(BANK).html: FraCaS.pgf FeedGF.hs ToHTML.hs prefix.html $(BANK)I.hs
	cat prefix.html > $@
	runhaskell FeedGF.hs | gf -run FraCaS.pgf | runhaskell ToHTML.hs >> $@

FraCaS.pgf: $(GF-FILES)
	gf -s -make src/FraCaSEng.gf src/FraCaSSwe.gf

$(BANK)I.hs: src/$(BANK)I.gf
	sed -e 's/--#.*//' -e 's/incomplete.*/module $(BANK)I where/' -e 's/lincat.*/bank =/' -e 's/^lin /  ("/' -e 's/ = /", "/' -e 's/;$$/"):/' -e 's/^}/ []/' < $< > $@
