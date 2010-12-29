all: freq

funs:
	echo "pg -funs | wf -file=kotusfuns.txt" | gf -run ../DictCompFinAbs.gf

freq:
	runghc Freq.hs >src.tmp
	cp prelFreqFinAbs FreqFinAbs.gf
	grep ":" src.tmp >>FreqFinAbs.gf
	echo "}" >>FreqFinAbs.gf
	cp prelFreqFin FreqFin.gf
	grep "=" src.tmp >>FreqFin.gf
	echo "}" >>FreqFin.gf

