RUNGHC=runghc
RUNMAKE=$(RUNGHC) Make.hs

.PHONY: all present alltenses lang api math prelude test demo synopsis link compiled clean

all: link prelude present alltenses compat

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
	gfc prelude/*.gf
	cp -p prelude/*.gfo ../prelude

test:
	$(RUNMAKE) test

demo:
	$(RUNMAKE) demo

synopsis:
	cd doc ; $(RUNGHC) MkSynopsis ; cd ..

link:
	chmod a+x mkPresent

compiled:
	(cd .. && tar -zcf resource-compiled.tar.gz prelude alltenses present)

clean:
	$(RUNMAKE) clean

