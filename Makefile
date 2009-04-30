.PHONY: all gf install doc clean sdist lib

all: gf lib

dist/setup-config:
	runghc Setup.lhs configure

gf: dist/setup-config
	runghc Setup.lhs build

install:
	runghc Setup.lhs install

doc:
	runghc Setup.lhs haddock

clean:
	runghc Setup.lhs clean

sdist:
	runghc Setup.lhs sdist

lib:
	$(MAKE) -C lib/resource clean all
