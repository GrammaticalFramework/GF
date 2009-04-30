RUNGHC=runghc
RUNMAKE=$(RUNGHC) Make.hs

.PHONY: all present alltenses lang api math test demo synopsis link compiled clean

all: link present alltenses math

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

math:
	$(RUNMAKE) math

compat:
	gf -batch */Compatibility*.gf
	cp -p */Compatibility*.gfo ../alltenses/
	cp -p */Compatibility*.gfo ../present/
#	$(RUNMAKE) present compat
#	$(RUNMAKE) compat

test:
	$(RUNMAKE) test

demo:
	$(RUNMAKE) demo

synopsis:
	cd doc ; $(RUNGHC) MkSynopsis ; cd ..

link:
	chmod a+x mkPresent

compiled:
	(cd .. && tar -zcf resource-compiled.tar.gz prelude alltenses present mathematical)

clean:
	$(RUNMAKE) clean

