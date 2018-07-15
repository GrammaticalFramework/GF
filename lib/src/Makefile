RUNGHC=runghc

dict: DictBul DictEng DictEst DictFin DictFre DictRus DictGer DictSwe

initdict:
	@mkdir -p ../dict/

DictBul: initdict
	gf -batch bulgarian/DictBul.gf +RTS -K100M
	cp -p bulgarian/DictBul*.gfo ../dict/

DictEng: initdict
	gf -batch english/DictEng.gf +RTS -K100M
	cp -p english/DictEng*.gfo ../dict

DictEst: initdict
	gf -batch estonian/DictEst.gf +RTS -K200M
	cp -p estonian/DictEst*.gfo ../dict

DictFin: initdict
	gf -batch finnish/DictFin.gf +RTS -K100M
	cp -p finnish/DictFin*.gfo ../dict

DictFre: initdict
	-gf -batch french/DictFre.gf +RTS -K100M
	-cp -p french/DictFre*.gfo ../dict

DictGer: initdict
	gf -batch german/DictGer.gf +RTS -K100M
	cp -p german/DictGer*.gfo ../dict

DictRus: initdict
	gf -batch russian/DictRus.gf +RTS -K200M
	cp -p russian/DictRus*.gfo ../dict

DictSwe: initdict
	gf -batch swedish/DictSwe.gf +RTS -K100M
	cp -p swedish/DictSwe*.gfo ../dict

GFMKD=gf -s -batch -make -literal=PN -gfo-dir ../dict
DictBul.pgf: initdict ;  $(GFMKD) -name=DictBul bulgarian/DictBul.gf +RTS -K100M
DictEng.pgf: initdict ;  $(GFMKD) -name=DictEng english/DictEng.gf   +RTS -K100M
DictEst.pgf: initdict ;  $(GFMKD) -name=DictEst estonian/DictEst.gf  +RTS -K200M
DictFin.pgf: initdict ;  $(GFMKD) -name=DictFin finnish/DictFin.gf   +RTS -K100M
DictFre.pgf: initdict ; -$(GFMKD) -name=DictFre french/DictFre.gf    +RTS -K100M
DictGer.pgf: initdict ;  $(GFMKD) -name=DictGer german/DictGer.gf    +RTS -K100M
DictHin.pgf: initdict ; -$(GFMKD) -name=DictHin hindi/DictHinWSJ.gf  +RTS -K100M
DictMlt.pgf: initdict ;  $(GFMKD) -name=DictMlt maltese/DictMlt.gf   +RTS -K100M
DictRus.pgf: initdict ;  $(GFMKD) -name=DictRus russian/DictRus.gf   +RTS -K200M
DictSwe.pgf: initdict ;  $(GFMKD) -name=DictSwe swedish/DictSwe.gf   +RTS -K100M
DictTur.pgf: initdict ;  $(GFMKD) -name=DictTur turkish/DictTur.gf   +RTS -K100M
DictUrd.pgf: initdict ;  $(GFMKD) -name=DictUrd urdu/DictUrd.gf      +RTS -K100M

# thai with pronunciation
thp:
	cd thai ; runghc ThaiScript.hs ; cd ..
