GF=../../bin/gf

.PHONY: show-path all test pretest langs present mathematical multimodal compiled treebank stat gfdoc clean

all: show-path present mathematical multimodal langs compiled

show-path:
	@echo GF_LIB_PATH=$(GF_LIB_PATH)

test:
	echo "gr -cat=Text -number=11 -prob | tb" | $(GF) -nocf -probs=lang.gfprob langs.gfcm

pretest:
	echo "gr -cat=Cl -number=11 -prob | tb" | $(GF) -probs=lang.gfprob -path=present:prelude -nocf ../present/Lang???.gfc

langs:
	echo "s ;; pm | wf langs.gfcm" | $(GF) -nocf -src */Lang??*.gf english/LangEng.gf +RTS -M800M -K100M
	cp -p */*.gfc */*.gfr ../alltenses

present:
	chmod u+x mkPresent
	$(GF) -make -src -preproc=./mkPresent */Lang??*.gf +RTS -M800M -K100M
	mv */*.gfc */*.gfr ../present

mathematical:
	$(GF) -make -nocf -preproc=./mkPresent mathematical/Mathematical???.gf
	mv mathematical/*.gfc ../mathematical

multimodal:
	$(GF) -make -nocf -preproc=./mkPresent multimodal/Multimodal???.gf
	mv multimodal/*.gfc multimodal/*.gfr ../multimodal

compiled:
	cd .. ; tar cvfz compiled.tgz alltenses/ mathematical/ multimodal/ present/ prelude/*.gf?

treebank:
	gf <mkTreebank.gfs

stat:
	wc */*.gfc

gfdoc:
	gfdoc -txthtml abstract/*.gf
	gfdoc -txthtml */Paradigms*.gf
	gfdoc -txthtml mathematical/Mathematical.gf
	gfdoc -txthtml mathematical/Symbol.gf
	gfdoc -txthtml mathematical/Predication.gf
	gfdoc -txthtml multimodal/Demonstrative.gf
	gfdoc -txthtml multimodal/Multimodal.gf
	gfdoc -txthtml ../prelude/*.gf
	mv abstract/*.html doc/gfdoc
	mv mathematical/*.html doc/gfdoc
	mv multimodal/*.html doc/gfdoc
	mv */Paradigms*.html doc/gfdoc
	cp */Irreg???.gf doc/gfdoc
	mv ../prelude/*.html doc/gfdoc

clean:
	-rm */*.gfc */*.gfr */*.gf~

