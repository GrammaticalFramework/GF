RUNGHC=runghc
RUNMAKE=$(RUNGHC) Make.hs

all: link present alltenses math

present:
	$(RUNMAKE) present lang
	$(RUNMAKE) present api

alltenses: lang api

lang:
	$(RUNMAKE) lang

api:
	$(RUNMAKE) api

math:
	$(RUNMAKE) math

test:
	$(RUNMAKE) test

synopsis:
	cd doc ; $(RUNGHC) MkSynopsis ; cd ..

link:
	chmod a+x mkPresent

clean:
	$(RUNMAKE) clean

