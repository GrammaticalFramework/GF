gf: abs cnc

abs:
	cp prelDictFinAbs DictFinAbs.gf
	runghc Kotus.hs <src/kotus-sanalista_v1.xml | grep ":" >>DictFinAbs.gf
	echo "}" >>DictFinAbs.gf
cnc:
	cp prelDictFin DictFin.gf
	runghc Kotus.hs <src/kotus-sanalista_v1.xml | grep "=" >>DictFin.gf
	echo "}" >>DictFin.gf
