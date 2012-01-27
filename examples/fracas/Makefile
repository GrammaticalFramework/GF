
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
	rm -f src/*.gfo src/*.pyc .DS_Store */.DS_Store

distclean: clean
	rm -f build/$(BANK).*
	rm -f dist/$(ZIPFILE)

dist: build clean
	mkdir -p dist
	rm -f dist/$(ZIPFILE)
	zip dist/$(ZIPFILE) $(FILES-TO-ZIP)

build/$(BANK).%: $(GF-FILES)
	python build_fracasbank.py $* src/$(BANK)I.gf $(LANGUAGES:%=src/$(BANK)%.gf) > $@

