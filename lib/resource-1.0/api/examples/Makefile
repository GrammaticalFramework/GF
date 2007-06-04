all: html gfs exx links 

links:
	runghc MkLinks

gfs:
	runghc mkgfs.hs

exx:
	gf ExxSwe.gf ExGer.gf ExFre.gf ExFin.gf ExxEng.gf <exx.gfs

html:
	cp ../Constructors.gf .
	gfdoc -txthtml Constructors.gf
