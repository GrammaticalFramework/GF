compile = runghc Compile 

all: src compdemo linkdemo

src:
	runghc MkMini.hs

compdemo:
	$(compile) API Afr Bul Cat Dan Dut Eng Fin Fre Ger Hin Ita Jap Lav Nep Nor Pes Pnb Pol Ron Rus Snd Spa Swe Tha Urd

linkdemo:
	$(compile) -link API Afr Bul Cat Dan Dut Eng Fin Fre Ger Hin Ita Jap Lav Nep Nor Pes Pnb Pol Ron Rus Snd Spa Swe Tha Urd
