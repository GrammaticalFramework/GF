GF=gf+
SRC=../

all: compiler

compiler:
	echo "pm | wf Imper.gfcm ;; pg -lang=ImperC -printer=lbnf | wf ImperC.tmp" | $(GF) $(SRC)ImperC.gf $(SRC)ImperJVM.gf
	echo "entrypoints Program, Stm, Exp ;" >entry.tmp
	cat entry.tmp ImperC.tmp >ImperC.cf
	bnfc -m -prof ImperC.cf
	make -f Makefile
	rm *.tmp
	jasmin runtime.j
