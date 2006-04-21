#GF=/users/mdstud/ltec06/GF
GF=/home/aarne/GF

all:
	make gf ; make ghc
ghc:
	ghc -fglasgow-exts --make UseDatabase.hs -o query ; strip query
gf:
	echo "pg -printer=haskell | wf GSyntax.hs ;; pm | wf database.gfcm" | gf DatabaseEng.gf
link:
	ln -s $(GF)/src/GF
	ln -s $(GF)/src/Transfer
#	export GF_LIB_PATH=$(GF)/lib
clean:
	rm *.hi *.o
