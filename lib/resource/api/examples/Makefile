all: html gfs exx links 

links:
	runghc MkLinks

gfs:
	runghc mkgfs.hs

exx:
	gf exxs.gfcm <exx.gfs

gfcm:
	echo "pm | wf exxs.gfcm" | gf ExxSwe.gf ExxGer.gf ExxFin.gf ExxEng.gf 
#ExxFre takes too long

html:
	cp ../Constructors.gf .
	gfdoc -txthtml Constructors.gf
