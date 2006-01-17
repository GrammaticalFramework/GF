test:
	gf -src english/LangEng.gf swedish/LangSwe.gf german/LangGer.gf

stat:
	wc english/*.gfc 
	wc swedish/*.gfc 
	wc german/*.gfc

gfdoc:
	gfdoc -txthtml abstract/*.gf
	gfdoc -txthtml */Paradigms*.gf
	mv abstract/*.html doc/gfdoc
	mv */Paradigms*.html doc/gfdoc
