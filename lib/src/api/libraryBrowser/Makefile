all: pgf

pgf: 
	gf -make LibraryBrowser???.gf

linearizations:
	echo "pg -funs" | gf alltenses/Lang.gfo | runghc MkLinAPI.hs 

