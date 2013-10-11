PROBSFILE=../../treebanks/PennTreebank/ParseEngAbs.probs

all: TranslateEng TranslateBul TranslateFre TranslateBulEngFre

TranslateEng:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEng TranslateEng.gf

TranslateBul:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateBul TranslateBul.gf

TranslateEngBul:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngBul TranslateEng.pgf TranslateBul.pgf

TranslateFre:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateFre TranslateFre.gf

TranslateEngFre:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateEngFre TranslateEng.pgf TranslateFre.pgf

TranslateBulEngFre:
	gf -make -literal=Symb -probs=$(PROBSFILE) -name=TranslateBulEngFre TranslateBul.pgf TranslateEng.pgf TranslateFre.pgf

