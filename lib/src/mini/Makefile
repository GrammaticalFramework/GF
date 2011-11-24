compile = runghc Compile 

all: src pgf

src:
	runghc MkMini.hs

pgf: src
	gf -make -optimize-pgf MiniGrammar???.gf +RTS -K100M

gf: src
	gf -batch MiniGrammar???.gf

compdemo:
	$(compile) Afr Bul Cat Dan Dut Eng Fin Fre Ger Ita Nep Nor Pnb Pes Pol Rus Spa Swe Tha Urd

linkdemo:
	$(compile) -link Afr Bul Cat Dan Dut Eng Fin Fre Ger Ita Nep Nor Pnb Pes Pol Rus Spa Swe Tha Urd
