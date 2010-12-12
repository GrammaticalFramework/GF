.PHONY: abstract synopsis

all: exx synopsis

index:
	txt2tags -thtml index.txt
synopsis:
	runghc MkSynopsis.hs

categories-imagemap.html: categories.dot
	dot -Tcmapx $^ > $@

abstract:
	gfdoc -txthtml ../src/abstract/*.gf
	mv ../src/abstract/*.html abstract

exx-script:
	runghc MkExx.hs <api-examples.txt >api-examples.gfs
exx: exx-script
	gf -retain -s ../alltenses/TryBul.gfo <api-examples.gfs >api-examples-Bul.txt
	gf -retain -s ../alltenses/TryCat.gfo <api-examples.gfs >api-examples-Cat.txt
	gf -retain -s ../alltenses/TryDan.gfo <api-examples.gfs >api-examples-Dan.txt
	gf -retain -s ../alltenses/TryDut.gfo <api-examples.gfs >api-examples-Dut.txt
	gf -retain -s ../alltenses/TryEng.gfo <api-examples.gfs >api-examples-Eng.txt
	gf -retain -s ../alltenses/TryFin.gfo <api-examples.gfs >api-examples-Fin.txt
	gf -retain -s ../alltenses/TryFre.gfo <api-examples.gfs >api-examples-Fre.txt
	gf -retain -s ../alltenses/TryGer.gfo <api-examples.gfs >api-examples-Ger.txt
	gf -retain -s ../alltenses/TryIta.gfo <api-examples.gfs >api-examples-Ita.txt
	gf -retain -s ../alltenses/TryNor.gfo <api-examples.gfs >api-examples-Nor.txt
	gf -retain -s ../alltenses/TryPol.gfo <api-examples.gfs >api-examples-Pol.txt
	gf -retain -s ../alltenses/TryRon.gfo <api-examples.gfs >api-examples-Ron.txt
	gf -retain -s ../alltenses/TrySpa.gfo <api-examples.gfs >api-examples-Spa.txt
	gf -retain -s ../alltenses/TrySwe.gfo <api-examples.gfs >api-examples-Swe.txt
