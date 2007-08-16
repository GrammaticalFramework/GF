all: book

tuthtml:
	txt2tags -thtml --toc gf-tutorial2_9.txt
tuttex:
	txt2tags -ttex --toc gf-tutorial2_9.txt
	cat prelude gf-tutorial2_9.tex >tmp.tex
	mv tmp.tex gf-tutorial2_9.tex
	pdflatex gf-tutorial2_9.tex
	pdflatex gf-tutorial2_9.tex 
book:
	txt2tags -ttex --toc gf-book.txt
	cat prelude gf-book.tex >tmp.tex
	mv tmp.tex gf-book.tex
	pdflatex gf-book.tex
	pdflatex gf-book.tex 
