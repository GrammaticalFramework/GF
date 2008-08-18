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

clean:
	cabal clean
