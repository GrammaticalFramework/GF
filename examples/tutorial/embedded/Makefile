all:
	gfc --make -haskell MathEng.gf MathFre.gf
	ghc --make -o ./math TransferLoop.hs
	strip math

clean: 
	rm -f *.gfo *.o *.hi

distclean:
	rm -f GSyntax.hs math Math.gfcc *.gfo *.o *.hi

