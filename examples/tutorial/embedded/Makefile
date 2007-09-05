all: gf hs run

gf:
	echo "pm | wf math.gfcm" | gf MathEng.gf MathFre.gf

hs: gf
	echo "pg -printer=haskell | wf GSyntax.hs" | gf math.gfcm

run: hs
	ghc --make -o ./math TransferLoop.hs
	strip math

clean: 
	rm -f *.gfc *.gfr *.o *.hi

distclean:
	rm -f GSyntax.hs math math.gfcm *.gfc *.gfr *.o *.hi

