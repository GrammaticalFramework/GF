all: html tex

html:
	txt2tags -thtml --toc gf-tutorial2_9.txt
tex:
	txt2tags -ttex --toc gf-tutorial2_9.txt
	cat prelude gf-tutorial2_9.tex >tmp.tex
	mv tmp.tex gf-tutorial2_9.tex
	pdflatex gf-tutorial2_9.tex
	pdflatex gf-tutorial2_9.tex 
