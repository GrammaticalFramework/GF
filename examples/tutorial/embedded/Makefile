all:
	gfc --make --output-format=haskell QueryEng.gf QuerySpa.gf
	ghc --make -o ./math TransferLoop.hs
	strip math
