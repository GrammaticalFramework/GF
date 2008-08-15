.PHONY: gf.fcgi food demo

gf.fcgi: 
	cabal configure
	cabal build
	cp dist/build/gf.fcgi/gf.fcgi .

food:
	gfc --make --name=grammar ../../examples/tutorial/food/Food{Eng,Ita}.gf

demo: 
#	gfc +RTS -K100M -RTS --make --name=grammar ../../lib/resource/demo/Demo{Bul,Cat,Dan,Eng,Fin,Fre,Ger,Ita,Nor,Rus,Spa,Swe}.gf
	gfc +RTS -K100M -RTS --make --name=grammar ../../lib/resource/demo/Demo{Eng,Swe}.gf
