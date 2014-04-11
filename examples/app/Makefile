all: AppEng.pgf AppSwe.pgf AppBul.pgf AppIta.pgf AppSpa.pgf AppFre.pgf AppGer.pgf AppHin.pgf AppChi.pgf AppFin.pgf App10

PROBSFILE=./app.probs
GFODIR=./gfos

S=-s
GFMKT=mkdir -p $(GFODIR) && gf $S -make -literal=Symb -probs=$(PROBSFILE) -gfo-dir $(GFODIR)


# Dummy targets, just for convenience
App: AppEng AppBul AppChi AppGer AppSwe AppHin AppFin AppFre AppIta AppSpa App10
AppEng: AppEng.pgf
AppBul: AppBul.pgf
AppChi: AppChi.pgf
AppGer: AppGer.pgf
AppSwe: AppSwe.pgf
AppHin: AppHin.pgf
AppFin: AppFin.pgf
AppFre: AppFre.pgf
AppIta: AppIta.pgf
AppSpa: AppSpa.pgf

TRANSLATE10=AppEng.pgf AppBul.pgf AppChi.pgf AppGer.pgf AppSwe.pgf AppHin.pgf AppFin.pgf AppFre.pgf AppIta.pgf AppSpa.pgf
TRANSLATE11=$(TRANSLATE10) AppDut.pgf
# With dependencies:
App11.pgf: $(TRANSLATE11)
	$(GFMKT) -name=App11 $(TRANSLATE11) +RTS -K200M

# Without dependencies:
App11:
	$(GFMKT) -name=App11 $(TRANSLATE11) +RTS -K200M

# Without dependencies:
App10:
	$(GFMKT) -name=App10 $(TRANSLATE10) +RTS -K200M

# With dependencies:
App10.pgf: $(TRANSLATE10)
	$(GFMKT) -name=App8 $(TRANSLATE10) +RTS -K200M

# App grammars for individual languages
AppEng.pgf:: ; $(GFMKT) -name=AppEng AppEng.gf
AppBul.pgf:: ; $(GFMKT) -name=AppBul AppBul.gf
AppChi.pgf:: ; $(GFMKT) -name=AppChi AppChi.gf +RTS -K64M
AppDut.pgf:: ; $(GFMKT) -name=AppDut AppDut.gf +RTS -K64M
AppFin.pgf:: ; $(GFMKT) -name=AppFin AppFin.gf +RTS -K64M
AppGer.pgf:: ; $(GFMKT) -name=AppGer AppGer.gf +RTS -K64M
AppHin.pgf:: ; $(GFMKT) -name=AppHin AppHin.gf
AppFre.pgf:: ; $(GFMKT) -name=AppFre AppFre.gf +RTS -K64M
AppIta.pgf:: ; $(GFMKT) -name=AppIta AppIta.gf +RTS -K64M
AppSpa.pgf:: ; $(GFMKT) -name=AppSpa AppSpa.gf +RTS -K64M
AppSwe.pgf:: ; $(GFMKT) -name=AppSwe AppSwe.gf

# language pairs to test
AppEngSwe: ; $(GFMKT) -name=AppEngSwe AppEng.pgf AppSwe.pgf
App10: ; $(GFMKT) -name=App10 AppEng.pgf AppSwe.pgf AppBul.pgf AppIta.pgf AppSpa.pgf AppFre.pgf AppGer.pgf AppHin.pgf AppChi.pgf AppFin.pgf +RTS -K200M

