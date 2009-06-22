# notice: GF_LIB_PATH has to point to GF/lib

all: magnet

magnet:
#	gfc --make -src --parser=off --name=fre BronzeageFre.gf +RTS -K100M
#	gfc --make -src --erasing=on --name=bul BronzeageBul.gf
	gfc --make -src --erasing=on --name=fin BronzeageFin.gf +RTS -K100M
	gfc --make -src --erasing=on --name=eng BronzeageEng.gf
	gfc --make -src --erasing=on --name=ger BronzeageGer.gf 
	gfc --make -src --erasing=on --name=scand BronzeageNor.gf BronzeageSwe.gf 
	gfc --make -src --name=rom BronzeageIta.gf BronzeageSpa.gf BronzeageFre.gf
	gfc --make --name=bronze eng.pgf fin.pgf ger.pgf rom.pgf scand.pgf

