all:
	cd ../.. && bnfc -p GF.Source -bytestrings -sharestrings GF/Source/GF.cf
	rm ErrM.hs
	perl -i -pe 's/GF.Source.ErrM/GF.Data.ErrM/' *.hs *.x *.y
	happy -gca ParGF.y
	alex -g LexGF.x
