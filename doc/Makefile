resource:
	gfdoc -txt2 ../lib/resource-1.0/abstract/*.gf
	gfdoc -txt2 ../lib/resource-1.0/*/Paradigms*.gf
	txt2tags --toc resource.txt
#	cat resource-preamble resource.tex >final-resource.tex
	sed -i 's/\\docum/%\\docum/g' resource.tex
	sed -i 's/ion\*{/ion{/g' resource.tex
	sed -i 's/\\paragraph{}//g' resource.tex
	sed -i 's/}\\\\/}/g' resource.tex
	cat resource-preamble resource.tex >resource.tmp
	mv resource.tmp resource.tex
	latex resource.tex
	latex resource.tex
	dvipdf resource.dvi

### Converting SVG logos to PNG, using convert from ImageMagick
logos:: Logos/gf00.png Logos/gf0.png

Logos/gf00.png: Logos/gf00.svg Makefile
	convert -background 'rgba(255,255,255,0)' -size 264x216 -depth 8 $< $@

Logos/gf0.png: Logos/gf0.svg Makefile
	convert -background 'rgba(255,255,255,0)' -size 320x240 -depth 8 $< $@

### Updating automatically generated HTML files

GENERATED_HTML=gf-developers.html

%.html: %.txt
	txt2tags $<

generated_html:: $(GENERATED_HTML)

gf-developers.html: gf-developers.txt
