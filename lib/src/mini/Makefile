compile = runghc Compile 

all: src compdemo linkdemo

src:
	runghc MkMini.hs

compdemo:
	$(compile) Afr Bul Cat Dan Dut Eng Fin Fre Ger Ita Lav Nep Nor Pes Pnb Pol Ron Rus Spa Swe Tha Urd

linkdemo:
	$(compile) -link Afr Bul Cat Dan Dut Eng Fin Fre Ger Ita Lav Nep Nor Pes Pnb Pol Ron Rus Spa Swe Tha Urd
