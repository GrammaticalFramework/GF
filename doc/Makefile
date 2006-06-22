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
