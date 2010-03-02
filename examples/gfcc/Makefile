all: pgf runtime

pgf: 
	gf -make ImperC.gf ImperJVM.gf

runtime: 
	java -jar jasmin.jar runtime.j

doc:
	pdflatex complin.tex
	pdflatex complin.tex

