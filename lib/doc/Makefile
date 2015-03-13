.PHONY: abstract synopsis

all: exx synopsis

GF_alltenses=$(GF_LIB_PATH)/alltenses

index:
	txt2tags -thtml index.txt
status:
	txt2tags -thtml status.txt
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
	gf -retain -s $(GF_alltenses)/TryAfr.gfo <api-examples.gfs >api-examples-Afr.txt
	gf -retain -s $(GF_alltenses)/TryBul.gfo <api-examples.gfs >api-examples-Bul.txt
	gf -retain -s $(GF_alltenses)/TryCat.gfo <api-examples.gfs >api-examples-Cat.txt
	gf -retain -s $(GF_alltenses)/TryChi.gfo <api-examples.gfs >api-examples-Chi.txt
	gf -retain -s $(GF_alltenses)/TryDan.gfo <api-examples.gfs >api-examples-Dan.txt
	gf -retain -s $(GF_alltenses)/TryDut.gfo <api-examples.gfs >api-examples-Dut.txt
	gf -retain -s $(GF_alltenses)/TryEng.gfo <api-examples.gfs >api-examples-Eng.txt
	gf -retain -s $(GF_alltenses)/TryEst.gfo <api-examples.gfs >api-examples-Est.txt
	gf -retain -s $(GF_alltenses)/TryFin.gfo <api-examples.gfs >api-examples-Fin.txt
	gf -retain -s $(GF_alltenses)/TryFre.gfo <api-examples.gfs >api-examples-Fre.txt
	gf -retain -s $(GF_alltenses)/TryGer.gfo <api-examples.gfs >api-examples-Ger.txt
	gf -retain -s $(GF_alltenses)/TryGre.gfo <api-examples.gfs >api-examples-Gre.txt
	gf -retain -s $(GF_alltenses)/TryHin.gfo <api-examples.gfs >api-examples-Hin.txt
	gf -retain -s $(GF_alltenses)/TryIta.gfo <api-examples.gfs >api-examples-Ita.txt
	gf -retain -s $(GF_alltenses)/TryJpn.gfo <api-examples.gfs >api-examples-Jpn.txt
	gf -retain -s $(GF_alltenses)/TryLav.gfo <api-examples.gfs >api-examples-Lav.txt
	gf -retain -s $(GF_alltenses)/TryMlt.gfo <api-examples.gfs >api-examples-Mlt.txt
	gf -retain -s $(GF_alltenses)/TryMon.gfo <api-examples.gfs >api-examples-Mon.txt
	gf -retain -s $(GF_alltenses)/TryNep.gfo <api-examples.gfs >api-examples-Nep.txt
	gf -retain -s $(GF_alltenses)/TryNor.gfo <api-examples.gfs >api-examples-Nor.txt
	gf -retain -s $(GF_alltenses)/TryPes.gfo <api-examples.gfs >api-examples-Pes.txt
	gf -retain -s $(GF_alltenses)/TryPnb.gfo <api-examples.gfs >api-examples-Pnb.txt
	gf -retain -s $(GF_alltenses)/TryPol.gfo <api-examples.gfs >api-examples-Pol.txt
	gf -retain -s $(GF_alltenses)/TryRon.gfo <api-examples.gfs >api-examples-Ron.txt
	gf -retain -s $(GF_alltenses)/TryRus.gfo <api-examples.gfs >api-examples-Rus.txt
	gf -retain -s $(GF_alltenses)/TrySnd.gfo <api-examples.gfs >api-examples-Snd.txt
	gf -retain -s $(GF_alltenses)/TrySpa.gfo <api-examples.gfs >api-examples-Spa.txt
	gf -retain -s $(GF_alltenses)/TrySwe.gfo <api-examples.gfs >api-examples-Swe.txt
	gf -retain -s $(GF_alltenses)/TryTha.gfo <api-examples.gfs >api-examples-Tha.txt
	gf -retain -s $(GF_alltenses)/TryUrd.gfo <api-examples.gfs >api-examples-Urd.txt
