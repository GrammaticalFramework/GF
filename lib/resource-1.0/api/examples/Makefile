all: html gfs exx links 

links:
	runghc MkLinks

gfs:
	runghc mkgfs.hs

exx:
	gf ExxSwe.gf ExxGer.gf ExxFre.gf ExxFin.gf ExxEng.gf <exx.gfs

html:
	cp ../Constructors.gf .
	gfdoc -txthtml Constructors.gf
