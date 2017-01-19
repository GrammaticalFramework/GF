compile = runghc +RTS -K200M -RTS Compile 

all: src compdemo linkdemo

src:
	runghc MkMini.hs

compdemo:
	$(compile) Afr Bul Cat Chi Dan Dut Eng Est Fin Fre Ger Gre Hin Ice Ita Jpn Lav Mlt Mon Nep Nor Nno Pes Pnb Pol Ron Rus Snd Spa Swe Tha Urd

linkdemo:
	$(compile) -link Afr Bul Cat Chi Dan Dut Eng Est Fin Fre Ger Gre Hin Ice Ita Jpn Lav Mlt Mon Nep Nor Nno Pes Pnb Pol Ron Rus Snd Spa Swe Tha Urd
