# notice: GF_LIB_PATH has to point to GF/next-lib

all: magnet

magnet:
	gfc --make -src --parser=off --name=fin BronzeageFin.gf
	gfc --make -src BronzeageEng.gf BronzeageSwe.gf BronzeageIta.gf
	gfc --make --name=grammar fin.pgf Bronzeage.pgf

