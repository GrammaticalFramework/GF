all:
	make test ; make paradigms
test:
	gf <mkTest.gfs
paradigms:
	gf <mkParadigms.gfs
gfdoc:
	gfdoc abstract/Combinations.gf abstract/Structural.gf english/ParadigmsEng.gf finnish/ParadigmsFin.gf french/ParadigmsFre.gf german/ParadigmsGer.gf italian/ParadigmsIta.gf russian/ParadigmsRus.gf swedish/ParadigmsSwe.gf ; mv */*.html doc

clean:
	rm -f */*.gfc */*.gfr
