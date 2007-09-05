all: gf hs run

gf:
	echo "pm | wf math.gfcm" | gf MathEng.gf MathFre.gf

hs: gf
	echo "pg -printer=haskell | wf haskell/GSyntax.hs" | gf math.gfcm

run: hs
	ghc --make -o ./math -ihaskell haskell/Run.hs
	strip math

clean: 
	rm -f *.gfc *.gfr haskell/*.o haskell/*.hi

distclean:
	rm -f GSyntax.hs math math.gfcm *.gfc *.gfr haskell/*.o haskell/*.hi

