nouns:
	grep N bornemann > nounsBR
	gf < nounsBR.gfs > nounsBR.out
	rm nounsBR

ediff-nouns:
	emacs --eval "(ediff-files \"nounsBR.gold\" \"nounsBR.out\" \
	(set-default-font \"-unknown-New Athena Unicode-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1\"))" &

adjectives:
	grep A bornemann > adjectivesBR
	gf < adjectivesBR.gfs > adjectivesBR.out
	rm adjectivesBR

ediff-adjectives:
	emacs --eval "(ediff-files \"adjectivesBR.gold\" \"adjectivesBR.out\" \
	(set-default-font \"-unknown-New Athena Unicode-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1\"))" &

verbs:
	grep V bornemann > verbsBR
	gf < verbsBR.gfs > verbsBR.out
	rm verbsBR

ediff-verbs:
	emacs --eval "(ediff-files \"verbsBR.gold\" \"verbsBR.out\" \
	(set-default-font \"-unknown-New Athena Unicode-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1\"))" &


# Paradigmen fuer alle Woerter aus lexicon.abstract erstellen (Lexicon.gf)
paradigms:
	gf < paradigms.gfs > paradigms.out

ediff-paradigms:
	emacs --eval "(ediff-files \"paradigms.gold\" \"paradigms.out\")" &

examples:
	gf -run < examples.gfs > examples.out
	emacs --eval "(ediff-files \"examples.gold\" \"examples.out\")" &

example-schemata:
	gf -run < schemata.gfs > schemata.out 
	emacs --eval "(ediff-files \"schemata.gold\" \"schemata.out\" \
	(set-default-font \"-unknown-New Athena Unicode-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1\"))" &

examplesLang:
	gf -run < examplesLang.gfs > examplesLang.out
	emacs --eval "(ediff-files \"examplesLang.gold\" \"examplesLang.out\")" &

# school tablet example
school-tablet:
	gf -run < school-tablet.gfs > school-tablet.out
	emacs --eval "(ediff-files \"school-tablet.gold\" \"school-tablet.out\")" &	
#	emacs --eval "(ediff-files \"school-tablet.gold\" \"school-tablet.out\" (set-font \"-unknown-New Athena Unicode-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1\")" &

school-tablet-2:
	gf -run < school-tablet-2.gfs > school-tablet-2.out

toGrc:
	gf -run < examples.tr.gfs

slides:	
	noweave -delay langGrc.slides.thessaloniki-2016.nw > langGrc.slides.thessaloniki-2016.tex
	latex -output-format=dvi -interaction=nonstopmode langGrc.slides.thessaloniki-2016.tex
	xdvi -s 6 -expert -offsets 2.5cm -paper a4 -geometry 550x400+1300+0

clean:
	rm -i *~
	rm -i *.aux
	rm -i *.log
