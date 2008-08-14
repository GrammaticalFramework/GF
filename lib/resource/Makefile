RUNGHC=runghc
RUNMAKE=$(RUNGHC) Make.hs

.PHONY: all present alltenses lang api math test demo synopsis link clean

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

test:
	$(RUNMAKE) test

demo:
	$(RUNMAKE) demo

synopsis:
	cd doc ; $(RUNGHC) MkSynopsis ; cd ..

link:
	chmod a+x mkPresent

clean:
	$(RUNMAKE) clean

