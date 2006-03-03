FIGURES=

NAME=typesystem

default: pdf

ps: $(NAME).ps

pdf: $(NAME).pdf

%.ps: %.dvi
	dvips -f $^ > $@

#%.pdf: %.ps
#	ps2pdf $^

%.pdf: %.dvi
	dvipdfm $^

%.dvi: %.tex # %.bib
	latex $*
#	bibtex $*
#	latex $*
#	latex $*

%.ps: %.dot
	dot -Tps -o $@ $^

%.eps: %.ps
	ps2epsi $^ $@

$(NAME).dvi: $(FIGURES)

clean:
	-rm -f *.aux *.dvi *.log *.blg *.bbl *.toc

psclean: clean
	-rm -f *.pdf *.ps

show: $(NAME).dvi
	xdvi $(NAME).dvi
