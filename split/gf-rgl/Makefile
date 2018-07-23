# A simple wrapper over the Haskell-based RGL build script

RUNMAKE=runghc Make.hs

.PHONY: build copy install clean

default: build copy

build: src/*/*.gf
	$(RUNMAKE) build

copy:
	$(RUNMAKE) copy

install: build copy

clean:
	$(RUNMAKE) clean
