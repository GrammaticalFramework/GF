all: langs mathematical multimodal

test:
	echo "gr -cat=Text -number=11 -prob | tb" | gf -nocf -probs=lang.gfprob langs.gfcm

langs:
	echo "s ;; pm | wf langs.gfcm" | gf -nocf */Lang??*.gf english/LangEng.gf +RTS -M500M -K100M

mathematical:
	gf -nocf -gfc mathematical/Mathematical???.gf  +RTS -M800M -K100M

multimodal:
	gf -nocf -gfc multimodal/Multimodal???.gf  +RTS -M500M -K100M

install:
	cp -p */*.gfc */*.gfr ../compiled

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

