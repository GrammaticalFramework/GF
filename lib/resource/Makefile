GF=gf -s

RTS=+RTS -M2000M -K200M -RTS

GFNewC=gfc -s $(RTS)
GFNew=$(GFNewC) -src
GFNewMake=$(GFNew) --make
GFNewPres=$(GFNew) -preproc=./mkPresent
GFNewPresC=$(GFNewC) -preproc=./mkPresent

GFCA=$(GF) -nocf
GFCC=$(GF) -nocf -make $(RTS)
GFC=$(GFCC) -src

# comment the first and uncomment the second in Windows
GFCP=$(GFC) -preproc=./mkPresent

GFCCP=$(GFCC) -preproc=./mkPresent

#GFCP=$(GFC) -preproc=mkPresent


.PHONY: show-path all prelude test alltenses pretest langs present mathematical multimodal compiled treebank stat gfdoc clean api

new:
	export GF='../../bin/gf -s' ; export GF_LIB_PATH='..'; $(MAKE) -e all

all: chmod show-path prelude present alltenses mathematical api langs compiled

chmod:
	chmod a+x mkPresent

show-path:
	@echo GF_LIB_PATH=$(GF_LIB_PATH)

test:
	echo "gr -cat=Text -number=11 -prob | tb" | $(GF) -nocf -probs=lang.gfprob langs.gfcm

pretest:
	echo "gr -cat=Cl -number=11 -prob | tb" | $(GF) -probs=lang.gfprob -path=present:prelude -nocf ../present/Lang???.gfc

prelude: 
	$(GFC) ../src/*.gf
	cp -p ../src/*.gf? ../prelude

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
	cp -p */*.gf? ../alltenses
	touch api/Constructors.gf
	$(GFCC) api/Syntax???.gf
	cp -p api/Constructors*.gf? ../alltenses
	cp -p api/Syntax*.gf? ../alltenses
	$(GFCC) api/Try???.gf
	$(GFCC) -path=alltenses:prelude:api:api/toplevel api/toplevel/OverLangEng.gf
	mv api/toplevel/Over*.gfc api/Try*.gf? ../alltenses

langs:
	echo "s ;; pm | wf langs.gfcm" | $(GFCA) -path=present:prelude ../present/Lang???.gfc
	mv langs.gfcm ../present
	echo "s ;; pm | wf langs.gfcm" | $(GFCA) -path=alltenses:prelude ../alltenses/Lang???.gfc
	mv langs.gfcm ../alltenses

api:
#	$(GFCC) api/Constructors???.gf
	$(GFCC) api/Combinators???.gf
	$(GFCC) api/Symbolic???.gf
	cp -p api/*.gf? ../api

arabic: chmod
	$(GFCP) arabic/GrammarAra.gf
	$(GFC) arabic/GrammarAra.gf

catalan: chmod
	$(GFCP) catalan/Catalan.gf
	$(GFC) catalan/Catalan.gf

present: chmod
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
	mv */*.gf? ../present
	touch api/Constructors.gf
	$(GFCCP) -path=api:present:prelude api/Syntax???.gf
	mv api/Constructors*.gf? ../present
	mv api/Syntax*.gf? ../present
	$(GFCCP) -path=api:present:prelude api/Try???.gf
	$(GFCCP) -path=present:prelude:api:api/toplevel api/toplevel/OverLangEng.gf
	mv api/toplevel/Over*.gfc api/Try???.gf? ../present


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

compiled: prelude present alltenses mathematical
	cd .. ; tar cfz compiled.tgz alltenses/ mathematical/ present/ prelude/*.gf?

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

gf3: 
	export GF_LIB_PATH=..; $(MAKE) -e gf3prelude gf3present gf3alltenses

gf3prelude: 
	$(GFNew) ../src/*.gf
	cp -p ../src/*.gfo ../prelude

gf3alltenses:
#	$(GFNew) arabic/GrammarAra.gf
#	$(GFNew) catalan/Catalan.gf
	$(GFNew) danish/Danish.gf
	$(GFNew) english/English.gf
	$(GFNew) finnish/Finnish.gf
	$(GFNew) french/French.gf
	$(GFNew) german/German.gf
	$(GFNew) italian/Italian.gf
	$(GFNew) norwegian/Norwegian.gf
	$(GFNew) russian/Russian.gf
	$(GFNew) spanish/Spanish.gf
	$(GFNew) swedish/Swedish.gf
	$(GFNew) common/ConstructX.gf
	cp -p */*.gfo ../alltenses
	touch api/Constructors.gf
	$(GFNewC) api/Syntax???.gf
	cp -p api/Constructors*.gfo ../alltenses
	cp -p api/Syntax*.gfo ../alltenses
#	$(GFNewC) api/Try???.gf
#	$(GFNewC) -path=alltenses:prelude:api:api/toplevel api/toplevel/OverLangEng.gf
#	mv api/toplevel/Over*.gfc api/Try*.gf? ../alltenses

gf3present:
#	$(GFNewPres) arabic/GrammarAra.gf
#	$(GFNewPres) catalan/Catalan.gf
	$(GFNewPres) danish/Danish.gf
	$(GFNewPres) english/English.gf
	$(GFNewPres) finnish/Finnish.gf
	$(GFNewPres) french/French.gf
	$(GFNewPres) german/German.gf
	$(GFNewPres) italian/Italian.gf
	$(GFNewPres) norwegian/Norwegian.gf
	$(GFNewPres) russian/Russian.gf
	$(GFNewPres) spanish/Spanish.gf
	$(GFNewPres) swedish/Swedish.gf
	$(GFNewPres) common/ConstructX.gf
	cp -p */*.gfo ../present
	touch api/Constructors.gf
	$(GFNewPresC) -path=present:prelude:api api/Syntax???.gf
	cp -p api/Constructors*.gfo ../present
	cp -p api/Syntax*.gfo ../present
#	$(GFNewPresC) api/Try???.gf
#	$(GFNewPresC) -path=present:prelude:api:api/toplevel api/toplevel/OverLangEng.gf
#	mv api/toplevel/Over*.gfc api/Try*.gf? ../present


gf3langs:
	mv ../present/LangSpa.gfo tmpLangSpa.gfo
	$(GFNew) -path=present:prelude -target=langs --make ../present/Lang???.gfo $(RTSS)
	mv langs.gfcc ../present
	mv tmpLangSpa.gfo ../present/LangSpa.gfo 
#	mv ../alltenses/LangSpa.gfo tmpLangSpa.gfo
#	$(GFNew) -path=alltenses:prelude -target=langs --make ../alltenses/Lang???.gfo $(RTSS)
#	mv langs.gfcc ../alltenses
#	mv tmpLangSpa.gfo ../alltenses/LangSpa.gfo 


clean:
	-rm -f */*.gfc */*.gfr */*.gf~ ../*/*.gfc ../*/*.gfr ../*/*.gf~ ../*/langs.gfcm ../compiled.tgz


