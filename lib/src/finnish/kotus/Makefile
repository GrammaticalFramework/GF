all: dict

dict:
	runghc Kotus.hs src/kotus-sanalista_v1.xml >src.tmp
	cp prelDictFinAbs DictFinAbs.gf
	grep ":" src.tmp >>DictFinAbs.gf
	echo "}" >>DictFinAbs.gf
	cp prelDictFin DictFin.gf
	grep "=" src.tmp >>DictFin.gf
	echo "}" >>DictFin.gf

compounds:
	runghc Kotus.hs src/kotus-sanalista_v1.xml -compounds >src-comp.tmp
	cp prelDictCompFinAbs DictCompFinAbs.gf
	grep ":" src-comp.tmp >>DictCompFinAbs.gf
	echo "}" >>DictCompFinAbs.gf
	cp prelDictCompFin DictCompFin.gf
	grep "=" src-comp.tmp >>DictCompFin.gf
	echo "}" >>DictCompFin.gf
