all: translator

translator:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=TransEngSwe NDTransEng.gf NDTransSwe.gf
bigtranslator:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=TransEngChiFinSwe NDTransEng.gf NDTransSwe.gf NDTransChi.gf NDTransFin.gf +RTS -K200M
midtranslator:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=TransEngChiSwe NDTransEng.gf NDTransSwe.gf NDTransChi.gf +RTS -K200M



app:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=AppEngSwe AppEng.gf AppSwe.gf
bigapp:
	gf -s -make -literal=Symb -probs=NDPredTrans.probs -name=AppEngChiFinSwe AppEng.gf AppSwe.gf AppChi.gf AppFin.gf +RTS -K200M

