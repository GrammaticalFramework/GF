M=3G

FolketsLexikon.gf:
	ghc --make -O ImportFolketsLexikon.hs -rtsopts
	./ImportFolketsLexikon +RTS -K32M -M$M

clean:
	rm -rf *.o *.hi *.gfo *.xml FolketsLexikon.gf ImportFolketsLexikon
