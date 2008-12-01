# notice: GF_LIB_PATH has to point to GF/next-lib

all: magnet

magnet:
#	gfc --make -src --parser=off --name=fre BronzeageFre.gf +RTS -K100M
#	gfc --make -src --erasing=on --name=bul BronzeageBul.gf
	gfc --make -src --parser=off --name=fin BronzeageFin.gf
	gfc --make -src --erasing=on --name=ger BronzeageGer.gf
	gfc --make -src BronzeageEng.gf BronzeageSwe.gf BronzeageIta.gf
	gfc --make --name=grammar bul.pgf fin.pgf ger.pgf Bronzeage.pgf

