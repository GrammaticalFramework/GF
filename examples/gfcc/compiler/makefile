GF=gf
SRC=../

all: parser gfcm runtime

compiler:
	echo "pm | wf Imper.gfcm ;; pg -lang=ImperC -printer=plbnf | wf ImperC.tmp" | $(GF) $(SRC)ImperC.gf $(SRC)ImperJVM.gf
	echo "entrypoints Program, Stm, Exp ;" >entry.tmp
	cat entry.tmp ImperC.tmp >ImperC.cf
	bnfc -m -prof ImperC.cf
	make -f Makefile
	rm *.tmp
	jasmin runtime.j

parser:
	ghc --make TestImperC.hs -o TestImperC

gfcm:
	echo "pm | wf Imper.gfcm" | $(GF) $(SRC)ImperC.gf $(SRC)ImperJVM.gf

runtime:
	jasmin runtime.j
