RUNGHC=runghc
RUNMAKE=$(RUNGHC) Make.hs

PROBSFILE=../../treebanks/PennTreebank/ParseEngAbs.probs
TPROBSFILE=translator/translate.probs

#GF_LIB_PATH=..

.PHONY: all present alltenses full lang api math prelude test demo parse synopsis link compiled constructX clean

all: link prelude constructX present alltenses 
#full

present:
	$(RUNMAKE) present lang
	$(RUNMAKE) present api
	$(RUNMAKE) present symbolic

alltenses: 
	$(RUNMAKE) alltenses lang
	$(RUNMAKE) alltenses api
	$(RUNMAKE) alltenses symbolic

full: 
	$(RUNMAKE) lang

lang:
	$(RUNMAKE) alltenses lang

api:
	$(RUNMAKE) alltenses api

dict: DictBul DictEng DictEst DictFin DictFre DictRus DictGer DictSwe

DictBul:
	gf -batch bulgarian/DictBul.gf +RTS -K100M
	cp -p bulgarian/DictBul*.gfo ../alltenses

DictEng:
	gf -batch english/DictEng.gf +RTS -K100M
	cp -p english/DictEng*.gfo ../alltenses

DictEst:
	gf -batch estonian/DictEst.gf +RTS -K100M
	cp -p estonian/DictEst*.gfo ../alltenses

DictFin:
	gf -batch finnish/DictFin.gf +RTS -K100M
	cp -p finnish/DictFin*.gfo ../alltenses

DictFre:
	gf -batch french/DictFre.gf +RTS -K100M
	cp -p french/DictFre*.gfo ../alltenses

DictGer:
	gf -batch german/DictGer.gf +RTS -K100M
	cp -p german/DictGer*.gfo ../alltenses

DictRus:
	gf -batch russian/DictRus.gf +RTS -K100M
	cp -p russian/DictRus*.gfo ../alltenses

DictSwe:
	gf -batch swedish/DictSwe.gf +RTS -K100M
	cp -p swedish/DictSwe*.gfo ../alltenses


# thai with pronunciation
thp:
	cd thai ; runghc ThaiScript.hs ; cd ..


prelude:
	gf -batch -path=prelude prelude/*.gf
	cp -p prelude/*.gfo ../prelude

constructX:
	gf -batch common/ConstructX.gf
	cp -p common/ConstructX.gfo ../prelude

MakeStructural:
	gf -batch */MakeStructural*.gf
	cp -p */MakeStructural*.gfo ../present
	cp -p */MakeStructural*.gfo ../alltenses

# the rest is mostly obsolete 24/8/2012

compatibility:
	$(RUNMAKE) present compat

test:
	$(RUNMAKE) test

demo:
	gf -make -name=Demo0 demo/DemoBul.gf demo/DemoCat.gf +RTS -K48M
	gf -make -name=Demo1 demo/DemoDan.gf demo/DemoDut.gf demo/DemoEng.gf
	gf -make -name=Demo2 demo/DemoFin.gf +RTS -K48M
	gf -make -name=Demo3 demo/DemoFre.gf demo/DemoGer.gf demo/DemoIta.gf demo/DemoNor.gf demo/DemoPol.gf +RTS -K48M
	gf -make -name=Demo4 demo/DemoRon.gf +RTS -K48M
	gf -make -name=Demo5 demo/DemoRus.gf demo/DemoSpa.gf demo/DemoSwe.gf
	gf -make -name=Demo6 demo/DemoUrd.gf +RTS -K48M
	gf -make Demo0.pgf Demo1.pgf Demo2.pgf Demo3.pgf Demo4.pgf Demo5.pgf Demo6.pgf
	rm Demo?.pgf

demoex:
	echo "gr -number=100 -cat=S | l -treebank | ps -to_html | wf -file=resdemo.html" | gf Demo.pgf

parse:
	$(RUNMAKE) parse

synopsis:
	cd ../doc ; $(RUNGHC) MkSynopsis ; cd ../src

link:
	chmod a+x mkPresent mkMinimal

compiled:
	(cd .. && tar -zcf resource-compiled.tar.gz prelude alltenses present)

clean:
	$(RUNMAKE) clean






# the previous translation grammar "Parse" now replaced by Translate:

# Dummy targets, just for convenience
Translate: TranslateEng TranslateBul TranslateChi TranslateGer TranslateSwe TranslateHin TranslateFin TranslateFre Translate8
TranslateEng: TranslateEng.pgf
TranslateBul: TranslateBul.pgf
TranslateChi: TranslateChi.pgf
TranslateGer: TranslateGer.pgf
TranslateDut: TranslateDut.pgf
TranslateSwe: TranslateSwe.pgf
TranslateHin: TranslateHin.pgf
TranslateFin: TranslateFin.pgf
TranslateFre: TranslateFre.pgf
TranslateIta: TranslateIta.pgf
TranslateSpa: TranslateSpa.pgf

S=-s
GFMKT=mkdir -p ../translator && gf $S -make -literal=PN,Symb -probs=$(TPROBSFILE) -gfo-dir ../translator

TRANSLATE8=TranslateEng.pgf TranslateBul.pgf TranslateChi.pgf TranslateGer.pgf TranslateSwe.pgf TranslateHin.pgf TranslateFin.pgf TranslateFre.pgf
TRANSLATE10=TranslateEng.pgf TranslateBul.pgf TranslateChi.pgf TranslateGer.pgf TranslateSwe.pgf TranslateHin.pgf TranslateFin.pgf TranslateFre.pgf TranslateIta.pgf TranslateSpa.pgf

TRANSLATE11=$(TRANSLATE10) TranslateDut.pgf

TRANSLATE15=$(TRANSLATE10) TranslateDut.pgf TranslateCat.pgf TranslateEst.pgf TranslateTha.pgf TranslateJpn.pgf

# Without dependencies:
Translate10:
	$(GFMKT) -name=Translate10 $(TRANSLATE10) +RTS -K32M

# With dependencies:
Translate10.pgf: $(TRANSLATE10)
	$(GFMKT) -name=Translate10 $(TRANSLATE10) +RTS -K32M

# Without dependencies:
Translate11:
	$(GFMKT) -name=Translate11 $(TRANSLATE11) +RTS -K32M

# With dependencies:
Translate11.pgf: $(TRANSLATE11)
	$(GFMKT) -name=Translate11 $(TRANSLATE11) +RTS -K32M

# Without dependencies:
Translate8:
	$(GFMKT) -name=Translate8 $(TRANSLATE8) +RTS -K32M

# With dependencies:
Translate8.pgf: $(TRANSLATE8)
	$(GFMKT) -name=Translate8 $(TRANSLATE8) +RTS -K32M

Translate15.pgf: $(TRANSLATE15)
	$(GFMKT) -name=Translate15 $(TRANSLATE15) +RTS -K32M

# Translate grammars for individual languages
TranslateEng.pgf:: ; $(GFMKT) -name=TranslateEng translator/TranslateEng.gf
TranslateBul.pgf:: ; $(GFMKT) -name=TranslateBul translator/TranslateBul.gf
TranslateChi.pgf:: ; $(GFMKT) -name=TranslateChi translator/TranslateChi.gf +RTS -K200M
TranslateFin.pgf:: ; $(GFMKT) -name=TranslateFin translator/TranslateFin.gf +RTS -K64M
TranslateGer.pgf:: ; $(GFMKT) -name=TranslateGer translator/TranslateGer.gf
TranslateDut.pgf:: ; $(GFMKT) -name=TranslateDut translator/TranslateDut.gf
TranslateHin.pgf:: ; $(GFMKT) -name=TranslateHin translator/TranslateHin.gf
TranslateFre.pgf:: ; $(GFMKT) -name=TranslateFre translator/TranslateFre.gf +RTS -K64M
TranslateSwe.pgf:: ; $(GFMKT) -name=TranslateSwe translator/TranslateSwe.gf
TranslateIta.pgf:: ; $(GFMKT) -name=TranslateIta translator/TranslateIta.gf +RTS -K64M
TranslateSpa.pgf:: ; $(GFMKT) -name=TranslateSpa translator/TranslateSpa.gf +RTS -K64M
TranslateCat.pgf:: ; $(GFMKT) -name=TranslateCat translator/TranslateCat.gf +RTS -K64M
TranslateEst.pgf:: ; $(GFMKT) -name=TranslateEst translator/TranslateEst.gf +RTS -K64M
TranslateTha.pgf:: ; $(GFMKT) -name=TranslateTha translator/TranslateTha.gf +RTS -K64M
TranslateJpn.pgf:: ; $(GFMKT) -name=TranslateJpn translator/TranslateJpn.gf +RTS -K64M

# Selected language pairs:
TranslateEngFin: ; $(GFMKT) -name=TranslateEngFin TranslateEng.pgf TranslateFin.pgf
TranslateEngGer: ; $(GFMKT) -name=TranslateEngGer TranslateEng.pgf TranslateGer.pgf
TranslateEngHin: ; $(GFMKT) -name=TranslateEngHin TranslateEng.pgf TranslateHin.pgf
TranslateEngBul: ; $(GFMKT) -name=TranslateEngBul TranslateEng.pgf TranslateBul.pgf
TranslateEngSpa: ; $(GFMKT) -name=TranslateEngSpa TranslateEng.pgf TranslateSpa.pgf
TranslateEngFre: ; $(GFMKT) -name=TranslateEngFre TranslateEng.pgf TranslateFre.pgf
TranslateEngSwe: ; $(GFMKT) -name=TranslateEngSwe TranslateEng.pgf TranslateSwe.pgf
TranslateEngChi: ; $(GFMKT) -name=TranslateEngChi TranslateEng.pgf TranslateChi.pgf




############################## begin Parse
## now obsolete

# Dummy targets, just for convenience
Parse: ParseEng ParseBul ParseChi ParseGer ParseSwe ParseHin ParseFin ParseFre Parse8
ParseEng: ParseEng.pgf
ParseBul: ParseBul.pgf
ParseChi: ParseChi.pgf
ParseGer: ParseGer.pgf
ParseSwe: ParseSwe.pgf
ParseHin: ParseHin.pgf
ParseFin: ParseFin.pgf
ParseFre: ParseFre.pgf

S=-s
GFMKP=mkdir -p ../parse8 && gf $S -make -literal=PN -probs=$(PROBSFILE) -gfo-dir ../parse8

PARSE8=ParseEng.pgf ParseBul.pgf ParseChi.pgf ParseGer.pgf ParseSwe.pgf ParseHin.pgf ParseFin.pgf ParseFre.pgf

# Without dependencies:
Parse8:
	$(GFMKP) -name=Parse8 $(PARSE8) +RTS -K200M

# With dependencies:
Parse8.pgf: $(PARSE8)
	$(GFMKP) -name=Parse8 $(PARSE8) +RTS -K200M

# Parse grammars for individual languages
ParseEng.pgf:: ; $(GFMKP) -name=ParseEng english/ParseEng.gf +RTS -K32M
ParseBul.pgf:: ; $(GFMKP) -name=ParseBul bulgarian/ParseBul.gf +RTS -K32M
ParseChi.pgf:: ; $(GFMKP) -name=ParseChi chinese/ParseChi.gf +RTS -K200M
ParseFin.pgf:: ; $(GFMKP) -name=ParseFin finnish/stemmed/ParseFin.gf +RTS -K200M
ParseGer.pgf:: ; $(GFMKP) -name=ParseGer german/ParseGer.gf +RTS -K200M
ParseHin.pgf:: ; $(GFMKP) -name=ParseHin hindi/ParseHin.gf +RTS -K200M
ParseFre.pgf:: ; $(GFMKP) -name=ParseFre french/ParseFre.gf +RTS -K200M
ParseSwe.pgf:: ; $(GFMKP) -name=ParseSwe swedish/ParseSwe.gf +RTS -K32M

ParseSpa.pgf:: ; $(GFMKP) -name=ParseSpa spanish/ParseSpa.gf

# Selected language pairs:
ParseEngFin: ; $(GFMKP) -name=ParseEngFin ParseEng.pgf ParseFin.pgf
ParseEngGer: ; $(GFMKP) -name=ParseEngGer ParseEng.pgf ParseGer.pgf
ParseEngHin: ; $(GFMKP) -name=ParseEngHin ParseEng.pgf ParseHin.pgf
ParseEngBul: ; $(GFMKP) -name=ParseEngBul ParseEng.pgf ParseBul.pgf
ParseEngSpa: ; $(GFMKP) -name=ParseEngSpa ParseEng.pgf ParseSpa.pgf
ParseEngFre: ; $(GFMKP) -name=ParseEngFre ParseEng.pgf ParseFre.pgf
ParseEngSwe: ; $(GFMKP) -name=ParseEngSwe ParseEng.pgf ParseSwe.pgf
ParseEngChi: ; $(GFMKP) -name=ParseEngChi ParseEng.pgf ParseChi.pgf

############################################## end Parse

