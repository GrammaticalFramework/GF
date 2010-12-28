gf: abs cnc

src:
	runghc Kotus.hs src/kotus-sanalista_v1.xml >src.tmp

compounds:
	runghc Kotus.hs src/kotus-sanalista_v1.xml -compounds >src.tmp

abs: src
	cp prelDictFinAbs DictFinAbs.gf
	grep ":" src.tmp >>DictFinAbs.gf
	echo "}" >>DictFinAbs.gf

cnc: src
	cp prelDictFin DictFin.gf
	grep "=" src.tmp >>DictFin.gf
	echo "}" >>DictFin.gf
