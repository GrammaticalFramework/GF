RUNGHC=runghc
RUNMAKE=$(RUNGHC) Make.hs

GF_LIB_PATH=..

.PHONY: all present alltenses lang api math prelude test demo parse synopsis link compiled constructX clean

all: link prelude constructX present alltenses compat

present:
	$(RUNMAKE) present lang
	$(RUNMAKE) present api

alltenses: 
	$(RUNMAKE) lang
	$(RUNMAKE) api

lang:
	$(RUNMAKE) lang

api:
	$(RUNMAKE) api

compat:
	$(RUNMAKE) present compat

prelude:
	gf -batch prelude/*.gf
	cp -p prelude/*.gfo ../prelude

constructX:
	gf -batch common/ConstructX.gf
	cp -p common/ConstructX.gfo ../prelude

MakeStructural:
	gf -batch */MakeStructural*.gf
	cp -p */MakeStructural*.gfo ../present
	cp -p */MakeStructural*.gfo ../alltenses

test:
	$(RUNMAKE) test

demo:
	$(RUNMAKE) demo

parse:
	$(RUNMAKE) parse

synopsis:
	cd doc ; $(RUNGHC) MkSynopsis ; cd ..

link:
	chmod a+x mkPresent mkMinimal

compiled:
	(cd .. && tar -zcf resource-compiled.tar.gz prelude alltenses present)

clean:
	$(RUNMAKE) clean

