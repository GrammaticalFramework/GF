all: translator

translator:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=TransEngSwe NDTransEng.gf NDTransSwe.gf
bigtranslator:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=TransEngFinSwe NDTransEng.gf NDTransSwe.gf NDTransFin.gf +RTS -K200M

