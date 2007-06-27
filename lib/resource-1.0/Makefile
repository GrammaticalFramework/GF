GF=gf -s
RTS=+RTS -M800M -K100M
RTSS=+RTS -M1000M -K100M

#may need this on amd64
RTS=+RTS -M2000M -K200M
RTSS=+RTS -M2000M -K200M

GFCA=$(GF) -nocf
GFCC=$(GF) -nocf -make
GFC=$(GFCC) -src

# comment the first and uncomment the second in Windows
GFCP=$(GFC) -preproc=./mkPresent

GFCCP=$(GFCC) -preproc=./mkPresent

#GFCP=$(GFC) -preproc=mkPresent


.PHONY: show-path all test alltenses pretest langs present mathematical multimodal compiled treebank stat gfdoc clean api

all: show-path present alltenses mathematical api multimodal compiled langs

show-path:
	@echo GF_LIB_PATH=$(GF_LIB_PATH)

test:
	echo "gr -cat=Text -number=11 -prob | tb" | $(GF) -nocf -probs=lang.gfprob langs.gfcm

pretest:
	echo "gr -cat=Cl -number=11 -prob | tb" | $(GF) -probs=lang.gfprob -path=present:prelude -nocf ../present/Lang???.gfc

alltenses:
#	$(GFC) arabic/GrammarAra.gf
#	$(GFC) catalan/Catalan.gf
	$(GFC) danish/Danish.gf
	$(GFC) english/English.gf
	$(GFC) finnish/Finnish.gf
	$(GFC) french/French.gf
	$(GFC) german/German.gf
	$(GFC) italian/Italian.gf
	$(GFC) norwegian/Norwegian.gf
	$(GFC) russian/Russian.gf
	$(GFC) spanish/Spanish.gf
	$(GFC) swedish/Swedish.gf
	$(GFC) common/ConstructX.gf
	cp -p */*.gfc */*.gfr ../alltenses
	touch api/Constructors.gf
	$(GFCC) api/Syntax???.gf
	cp -p api/Constructors*.gfc api/Constructors*.gfr ../alltenses
	cp -p api/Syntax*.gfc api/Syntax*.gfr ../alltenses



langs:
	echo "s ;; pm | wf langs.gfcm" | $(GFCA) -path=alltenses:prelude ../alltenses/Lang???.gfc $(RTSS)

api:
#	$(GFCC) api/Constructors???.gf
	$(GFCC) api/Combinators???.gf
	$(GFCC) api/Symbolic???.gf
	cp -p api/*.gfc api/*.gfr ../api

arabic:
	$(GFCP) arabic/GrammarAra.gf
	$(GFC) arabic/GrammarAra.gf

catalan:
	$(GFCP) catalan/Catalan.gf
	$(GFC) catalan/Catalan.gf

present:
#	$(GFCP) arabic/GrammarAra.gf
#	$(GFCP) catalan/Catalan.gf
	$(GFCP) danish/Danish.gf
	$(GFCP) english/English.gf
	$(GFCP) finnish/Finnish.gf
	$(GFCP) french/French.gf
	$(GFCP) german/German.gf
	$(GFCP) italian/Italian.gf
	$(GFCP) norwegian/Norwegian.gf
	$(GFCP) russian/Russian.gf
	$(GFCP) spanish/Spanish.gf
	$(GFCP) swedish/Swedish.gf
	$(GFCP) common/ConstructX.gf
	mv */*.gfc */*.gfr ../present
	touch api/Constructors.gf
	$(GFCCP) -path=api:present:prelude api/Syntax???.gf
	mv api/Constructors*.gfc api/Constructors*.gfr ../present
	mv api/Syntax*.gfc api/Syntax*.gfr ../present

mathematical:
	$(GFCC) mathematical/MathematicalEng.gf
	$(GFCC) mathematical/MathematicalNor.gf
	$(GFCC) mathematical/MathematicalGer.gf
	$(GFCC) mathematical/MathematicalSpa.gf
	$(GFCC) mathematical/MathematicalIta.gf
	$(GFCC) mathematical/MathematicalFre.gf
	$(GFCC) mathematical/MathematicalSwe.gf
	$(GFCC) mathematical/MathematicalFin.gf
	mv mathematical/*.gfc ../mathematical

multimodal:
	$(GF) -make -nocf multimodal/Multi???.gf
	mv multimodal/*.gfc ../multimodal

compiled:
	cd .. ; tar cfz compiled.tgz alltenses/ mathematical/ multimodal/ present/ prelude/*.gf?

treebank:
	gf <mkTreebank.gfs

stat:
	wc */*.gfc

gfdoc:
	gfdoc -txthtml abstract/*.gf
	gfdoc -txthtml */Paradigms*.gf
	gfdoc -txthtml mathematical/Mathematical.gf
	gfdoc -txthtml mathematical/Symbol.gf
	gfdoc -txthtml mathematical/Predication.gf
	gfdoc -txthtml multimodal/Multi.gf
	gfdoc -txthtml ../prelude/*.gf
	gfdoc -txthtml api/Combinators.gf
	gfdoc -txthtml api/Constructors.gf
	gfdoc -txthtml api/Symbolic.gf
	mv abstract/*.html doc/gfdoc
	mv mathematical/*.html doc/gfdoc
	mv multimodal/*.html doc/gfdoc
	mv api/*.html doc/gfdoc
	mv */Paradigms*.html doc/gfdoc
	cp */Irreg???.gf doc/gfdoc
	mv ../prelude/*.html doc/gfdoc

clean:
	-rm */*.gfc */*.gfr */*.gf~ ../*/*.gfc ../*/*.gfr ../*/*.gf~ ../compiled.tgz langs.gfcm


