all: Phrasebook App15.pgf

PROBSFILE=./app.probs
GFODIR=./gfos

.Phony: Phrasebook

Phrasebook:
	cd ../phrasebook ; make forApp ; cd ../app

S=-s
GFMKT=mkdir -p $(GFODIR) && gf $S -make -literal=PN,Symb -probs=$(PROBSFILE) -gfo-dir $(GFODIR)

APP11=AppEng.pgf AppBul.pgf AppChi.pgf AppGer.pgf AppSwe.pgf AppHin.pgf AppFin.pgf AppFre.pgf AppIta.pgf AppSpa.pgf AppDut.pgf
APP12=$(APP11) AppCat.pgf
APP13=$(APP12) AppJpn.pgf
APP14=$(APP13) AppTha.pgf
APP15=$(APP14) AppEst.pgf
APP16=$(APP15) AppRus.pgf

# With dependencies:
App11.pgf: $(APP11)
	$(GFMKT) -name=App11 $(APP11) +RTS -K200M
App12.pgf: $(APP12)
	$(GFMKT) -name=App12 $(APP12) +RTS -K200M
App13.pgf: $(APP13)
	$(GFMKT) -name=App13 $(APP13) +RTS -K200M
App14.pgf: $(APP14)
	$(GFMKT) -name=App14 $(APP14) +RTS -K200M
App15.pgf: $(APP15)
	$(GFMKT) -name=App15 $(APP15) +RTS -K200M
App16.pgf: $(APP16)
	$(GFMKT) -name=App16 $(APP16) +RTS -K200M

# Without dependencies:
App11:
	$(GFMKT) -name=App12 $(APP11) +RTS -K200M
App12:
	$(GFMKT) -name=App12 $(APP12) +RTS -K200M
App13:
	$(GFMKT) -name=App13 $(APP13) +RTS -K200M
App14:
	$(GFMKT) -name=App14 $(APP14) +RTS -K200M
App15:
	$(GFMKT) -name=App15 $(APP15) +RTS -K200M

# App grammars for individual languages
AppEng.pgf:: ; $(GFMKT) -name=AppEng AppEng.gf
AppBul.pgf:: ; $(GFMKT) -name=AppBul AppBul.gf
AppCat.pgf:: ; $(GFMKT) -name=AppCat AppCat.gf +RTS -K100M
AppChi.pgf:: ; $(GFMKT) -name=AppChi AppChi.gf +RTS -K100M
AppDut.pgf:: ; $(GFMKT) -name=AppDut AppDut.gf +RTS -K64M
AppEst.pgf:: ; $(GFMKT) -name=AppEst AppEst.gf +RTS -K64M
AppFin.pgf:: ; $(GFMKT) -name=AppFin AppFin.gf +RTS -K64M
AppGer.pgf:: ; $(GFMKT) -name=AppGer AppGer.gf +RTS -K64M
AppHin.pgf:: ; $(GFMKT) -name=AppHin AppHin.gf
AppFre.pgf:: ; $(GFMKT) -name=AppFre AppFre.gf +RTS -K64M
AppIta.pgf:: ; $(GFMKT) -name=AppIta AppIta.gf +RTS -K64M
AppJpn.pgf:: ; $(GFMKT) -name=AppJpn AppJpn.gf +RTS -K64M
AppSpa.pgf:: ; $(GFMKT) -name=AppSpa AppSpa.gf +RTS -K64M
AppSwe.pgf:: ; $(GFMKT) -name=AppSwe AppSwe.gf
AppTha.pgf:: ; $(GFMKT) -name=AppTha AppTha.gf

# language pairs to test
AppEngSwe: ; $(GFMKT) -name=AppEngSwe AppEng.pgf AppSwe.pgf
AppEngFin: ; $(GFMKT) -name=AppEngFin AppEng.pgf AppFin.pgf
AppEngChi: ; $(GFMKT) -name=AppEngChi AppEng.pgf AppChi.pgf

