PROBSFILE=../../treebanks/PennTreebank/ParseEngAbs.probs

GF=gf +RTS -K200M -RTS -make 

all: TranslateEng TranslateBul TranslateFre TranslateBulEngFre

TranslateBul:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateBul TranslateBul.gf

TranslateChi:
	$(GF) -s -literal=Symb -probs=$(PROBSFILE) -name=TranslateChi TranslateChi.gf

TranslateEng:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateEng TranslateEng.gf

TranslateFin:
	$(GF) -s -literal=Symb -probs=$(PROBSFILE) -name=TranslateFin TranslateFin.gf

TranslateFre:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateFre TranslateFre.gf

TranslateGer:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateGer TranslateGer.gf

TranslateHin:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateHin TranslateHin.gf

TranslateSwe:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateSwe TranslateSwe.gf




TranslateEngBul:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngBul TranslateEng.pgf TranslateBul.pgf

TranslateEngChi:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngChi TranslateEng.pgf TranslateChi.pgf

TranslateEngChiFinSwe:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngChiFinSwe TranslateEng.pgf TranslateChi.pgf TranslateFin.pgf TranslateSwe.pgf

TranslateEngFre:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngFre TranslateEng.pgf TranslateFre.pgf

TranslateEngSwe:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngSwe TranslateEng.pgf TranslateSwe.pgf

TranslateBulEngFre:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=TranslateBulEngFre TranslateBul.pgf TranslateEng.pgf TranslateFre.pgf

Translate7:
	$(GF) -literal=Symb -probs=$(PROBSFILE) -name=Translate7 TranslateEng.pgf TranslateChi.pgf TranslateFin.pgf TranslateSwe.pgf TranslateBul.pgf TranslateGer.pgf TranslateHin.pgf
# adding TranslateFre too heavy so far

