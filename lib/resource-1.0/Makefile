all: langs mathematical multimodal

test: langs
	echo "gr -cat=Text -number=11 -prob | tb" | gf -nocf -probs=lang.gfprob langs.gfcm

langs:
	echo "s ;; pm | wf langs.gfcm" | gf -nocf */Lang??*.gf english/LangEng.gf +RTS -M500M -K100M

present:
	gf -batch -nocf -preproc=./mkPresent */Lang??*.gf
	cp -p */*.gfc */*.gfr present

mathematical: present
	gf -batch -nocf -preproc=./mkPresent mathematical/Mathematical???.gf

multimodal: present
	gf -batch -nocf -preproc=./mkPresent multimodal/Multimodal???.gf

install:
	cp -p */*.gfc */*.gfr langs

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
	mv abstract/*.html doc/gfdoc
	mv mathematical/*.html doc/gfdoc
	mv multimodal/*.html doc/gfdoc
	mv */Paradigms*.html doc/gfdoc
	cp */Irreg???.gf doc/gfdoc

clean:
	rm */*.gfc */*.gfr */*.gf~

