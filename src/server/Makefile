GFCFLAGS = +RTS -K100M -RTS

.PHONY: gf.fcgi food demo

gf.fcgi: 
	cabal configure
	cabal build
	cp dist/build/gf.fcgi/gf.fcgi .

food:
	gfc --make --name=grammar ../../examples/tutorial/food/Food{Eng,Ita}.gf

demo: 
#	gfc $(GFCFLAGS) --make --name=grammar ../../lib/resource/demo/Demo{Bul,Cat,Dan,Eng,Fin,Fre,Ger,Ita,Nor,Rus,Spa,Swe}.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoBul ../../lib/resource/demo/DemoBul.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoCat ../../lib/resource/demo/DemoCat.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoDan ../../lib/resource/demo/DemoDan.gf
	gfc $(GFCFLAGS) --make --parser=on  --name=DemoEng ../../lib/resource/demo/DemoEng.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoFin ../../lib/resource/demo/DemoFin.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoFre ../../lib/resource/demo/DemoFre.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoGer ../../lib/resource/demo/DemoGer.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoIta ../../lib/resource/demo/DemoIta.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoNor ../../lib/resource/demo/DemoNor.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoRus ../../lib/resource/demo/DemoRus.gf
	gfc $(GFCFLAGS) --make --parser=off --name=DemoSpa ../../lib/resource/demo/DemoSpa.gf
	gfc $(GFCFLAGS) --make --parser=on  --name=DemoSwe ../../lib/resource/demo/DemoSwe.gf
	gfc $(GFCFLAGS) --name=grammar Demo???.pgf

lang: 
	gfc $(GFCFLAGS) --make --parser=off --name=LangBul ../../lib/resource/bulgarian/LangBul.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangCat ../../lib/resource/catalan/LangCat.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangDan ../../lib/resource/danish/LangDan.gf
	gfc $(GFCFLAGS) --make --parser=on  --name=LangEng ../../lib/resource/english/LangEng.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangFin ../../lib/resource/finnish/LangFin.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangFre ../../lib/resource/french/LangFre.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangGer ../../lib/resource/german/LangGer.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangIta ../../lib/resource/italian/LangIta.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangNor ../../lib/resource/norwegian/LangNor.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangRus ../../lib/resource/russian/LangRus.gf
	gfc $(GFCFLAGS) --make --parser=off --name=LangSpa ../../lib/resource/spanish/LangSpa.gf
	gfc $(GFCFLAGS) --make --parser=on  --name=LangSwe ../../lib/resource/swedish/LangSwe.gf
	gfc $(GFCFLAGS) --name=grammar Lang???.pgf

clean:
	cabal clean
