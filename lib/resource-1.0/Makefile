all: langs test

test:
	echo "gr -cat=S -number=11 -prob | tb" | gf -probs=lang.gfprob langs.gfcm
langs:
	echo "s ;; pm | wf langs.gfcm" | gf -src */Lang??*.gf english/LangEng.gf

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
