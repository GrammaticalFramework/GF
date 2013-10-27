PROBSFILE=../../treebanks/PennTreebank/ParseEngAbs.probs

all: TranslateEng TranslateBul TranslateFre TranslateBulEngFre

TranslateEng:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEng TranslateEng.gf

TranslateBul:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateBul TranslateBul.gf

TranslateChi:
	gf -make -s -literal=Symb -probs=$(PROBSFILE) -name=TranslateChi TranslateChi.gf

TranslateFin:
	gf -make -s -literal=Symb -probs=$(PROBSFILE) -name=TranslateFin TranslateFin.gf

TranslateFre:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateFre TranslateFre.gf

TranslateSwe:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateSwe TranslateSwe.gf

TranslateEngBul:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngBul TranslateEng.pgf TranslateBul.pgf

TranslateEngChi:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngChi TranslateEng.pgf TranslateChi.pgf

TranslateEngChiFinSwe:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngChiFinSwe TranslateEng.pgf TranslateChi.pgf TranslateFin.pgf TranslateSwe.pgf

TranslateEngFre:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngFre TranslateEng.pgf TranslateFre.pgf

TranslateBulEngFre:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateBulEngFre TranslateBul.pgf TranslateEng.pgf TranslateFre.pgf

