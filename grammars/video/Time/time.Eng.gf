-- Time grammar English

include time.Abs.gf ;


lin
hour0 = {s = refs ["null null"] (variants {["midnight"];["twelve"]}) "one"} ;
hour1 = {s = refs "one" (variants {["one"];["one a.m"]}) "two"} ; 
hour2 = {s = refs "two" (variants {["two"];["two a.m"]}) "three"} ; 
hour3 = {s = refs "three" (variants {["three"];["three a.m"]}) "four"} ; 
hour4 = {s = refs "four" (variants {["four"];["four a.m"]}) "five"} ; 
hour5 = {s = refs "five" (variants {["five"];["five a.m"]}) "six"} ; 
hour6 = {s = refs "six" (variants {["six"];["six a.m"]}) "seven"} ; 
hour7 = {s = refs "seven" (variants {["seven"];["seven a.m"]}) "eight"} ; 
hour8 = {s = refs "eight" (variants {["eight"];["eight a.m"]}) "nine"} ; 
hour9 = {s = refs "nine" (variants {["nine"];["nine a.m"]}) "ten"} ; 
hour10 = {s = refs "ten" (variants {["ten"];["ten a.m"]}) "eleven"} ; 
hour11 = {s = refs "eleven" (variants {["eleven"];["eleven a.m"]}) "twelve"} ; 
hour12 = {s = refs "twelve" (variants {["twelve"];["twelve a.m"]}) "one" } ; 
hour13 = {s = refs "thirten" (variants {["one"];["one p.m"]}) "two" };
hour14 = {s = refs "fourteen" (variants {["two"];["two p.m"]}) "three" } ;
hour15 = {s = refs "fifteen" (variants {["three"];["three p.m"]}) "four" } ;
hour16 = {s = refs "sixteen" (variants {["four"];["four p.m"]}) "five" } ;
hour17 = {s = refs "seventeen" (variants {["five"];["five p.m"]}) "six" } ;
hour18 = {s = refs "eighteen" (variants {["six"];["six p.m"]}) "seven" } ;
hour19 = {s = refs "nineteen" (variants {["seven"];["seven p.m"]}) "eight" } ;
hour20 = {s = refs "twenty" (variants {["eight"];["eight p.m"]}) "nine" } ;
hour21 = {s = refs ["twenty one"] (variants {["nine"];["nine p.m"]}) "eight" } ; 
hour22 = {s = refs ["twenty two"] (variants {["ten"];["ten p.m"]}) "eleven" } ;
hour23 = {s = refs ["twenty three"] (variants {["eleven"]}) (variants {["midnight"];["twelve"]})} ;


lin

minute0 = {s = mins (variants {["o'clock"];["sharp"];["hundred hours"]}) (variants{[""]}) (variants{})};
minute1 = {s = mins ["oh one"] (variants{["one minute past"];["one past"]}) (variants{})};
minute2 = {s = mins ["oh two"] (variants{["two minutes past"];["two past"]}) (variants{})};
minute3 = {s = mins ["oh three"] (variants{["three minutes past"];["three past"]}) (variants{})};
minute4 = {s = mins ["oh four"] (variants{["four minutes past"];["four past"]}) (variants{})};
minute5 = {s = mins ["oh five"] (variants{["five minutes past"];["five past"]}) (variants{})};
minute6 = {s = mins ["oh six"] (variants{["six minutes past"];["six past"]}) (variants{})};
minute7 = {s = mins ["oh seven"] (variants{["seven minutes past"];["seven past"]}) (variants{})};
minute8 = {s = mins ["oh eight"] (variants{["eight minutes past"];["eight past"]}) (variants{})};
minute9 = {s = mins ["oh nine"] (variants{["nine minutes past"];["nine past"]}) (variants{})};

minute10 = {s = mins ["ten"] (variants{["ten minutes past"];["ten past"]}) (variants{})};
minute11 = {s = mins ["eleven"] (variants{["eleven minutes past"];["eleven past"]}) (variants{})};
minute12 = {s = mins ["twelve"] (variants{["twelve minutes past"];["twelve past"]}) (variants{})};
minute13 = {s = mins ["thirteen"] (variants{["thirteen minutes past"];["thirteen past"]}) (variants{})};
minute14 = {s = mins ["fourteen"] (variants{["fourteen minutes past"];["fourteen past"]}) (variants{})};
minute15 = {s = mins ["fifteen"] (variants{["fifteen minutes past"];["fifteen past"];["quarter past"];["a quarter past"]}) (variants{})};
minute16 = {s = mins ["sixteen"] (variants{["sixteen minutes past"];["sixteen past"]}) (variants{})};
minute17 = {s = mins ["seventeen"] (variants{["seventeen minutes past"];["seventeen past"]}) (variants{})};
minute18 = {s = mins ["eightteen"] (variants{["eighteen minutes past"];["eighteen past"]}) (variants{})};
minute19 = {s = mins ["nineteen"] (variants{["nineteen minutes past"];["nineteen past"]}) (variants{})};

minute20 = {s = mins ["twenty"] (variants{["twenty minutes past"];["twenty past"]}) (variants{})};
minute21 = {s = mins ["twenty one"] (variants{["twenty one minutes past"];["twenty one past"]}) (variants{})};
minute22 = {s = mins ["twenty two"] (variants{["twenty two minutes past"];["twenty two past"]}) (variants{})};
minute23 = {s = mins ["twenty three"] (variants{["twenty three minutes past"];["twenty three past"]}) (variants{})};
minute24 = {s = mins ["twenty four"] (variants{["twenty four minutes past"];["twenty four past"]}) (variants{})};
minute25 = {s = mins ["twenty five"] (variants{["twenty five minutes past"];["twenty two five past"]}) (variants{})};
minute26 = {s = mins ["twenty six"] (variants{["twenty six minutes past"];["twenty six past"]}) (variants{})};
minute27 = {s = mins ["twenty seven"] (variants{["twenty seven minutes past"];["twenty seven past"]}) (variants{})};
minute28 = {s = mins ["twenty eight"] (variants{["twenty eight minutes past"];["twenty eight past"]}) (variants{})};
minute29 = {s = mins ["twenty nine"] (variants{["twenty nine minutes past"];["twenty nine past"]}) (variants{})};

minute30 = {s = mins ["thirty"] (variants{["thirty minutes past"];["thirty past"];["half past"]}) (variants{})};

minute31 = {s = mins ["thirty one"] (variants{["one minute past half past????"]}) (variants{["twenty nine minutes to"];["twenty nine to"]})};
minute32 = {s = mins ["thirty two"] (variants{}) (variants{["twenty eight minutes to"];["twenty eight to"]})};
minute33 = {s = mins ["thirty three"] (variants{}) (variants{["twenty seven minutes to"];["twenty seven to"]})};
minute34 = {s = mins ["thirty four"] (variants{}) (variants{["twenty six minutes to"];["twenty six to"]})};
minute35 = {s = mins ["thirty five"] (variants{}) (variants{["twenty five minutes to"];["twenty five to"]})};
minute36 = {s = mins ["thirty six"] (variants{}) (variants{["twenty four minutes to"];["twenty four to"]})};
minute37 = {s = mins ["thirty seven"] (variants{}) (variants{["twenty three minutes to"];["twenty three to"]})};
minute38 = {s = mins ["thirty eight"] (variants{}) (variants{["twenty two minutes to"];["twenty two to"]})};
minute39 = {s = mins ["thirty nine"] (variants{}) (variants{["twenty one minutes to"];["twenty one to"]})};
minute40 = {s = mins ["fourty"] (variants{}) (variants{["twenty minutes to"];["twenty to"]})};

minute41 = {s = mins ["fourty one"] (variants{}) (variants{["nineteen minutes to"];["nineteen to"]})};
minute42 = {s = mins ["fourty two"] (variants{}) (variants{["eightteen minutes to"];["eightteen to"]})};
minute43 = {s = mins ["fourty three"] (variants{}) (variants{["seventeen minutes to"];["seventeen to"]})};
minute44 = {s = mins ["fourty four"] (variants{}) (variants{["sixteen minutes to"];["sixteen to"]})};
minute45 = {s = mins ["fourty five"] (variants{["three quarters past???"]}) (variants{["fifteen minutes to"];["fifteen to"]})};
minute46 = {s = mins ["fourty six"] (variants{}) (variants{["fourteen minutes to"];["fourteen to"]})};
minute47 = {s = mins ["fourty seven"] (variants{}) (variants{["thirteen minutes to"];["thirteen to"]})};
minute48 = {s = mins ["fourty eight"] (variants{}) (variants{["twelve minutes to"];["twelve to"]})};
minute49 = {s = mins ["fourty nine"] (variants{}) (variants{["eleven minutes to"];["eleven to"]})};
minute50 = {s = mins ["fifty"] (variants{}) (variants{["ten minutes to"];["ten to"]})};

minute51 = {s = mins ["fifty one"] (variants{}) (variants{["nine minutes to"];["nine to"]})};
minute52 = {s = mins ["fifty two"] (variants{}) (variants{["eight minutes to"];["eight to"]})};
minute53 = {s = mins ["fifty three"] (variants{}) (variants{["seven minutes to"];["seven to"]})};
minute54 = {s = mins ["fifty four"] (variants{}) (variants{["six minutes to"];["six to"]})};
minute55 = {s = mins ["fifty five"] (variants{}) (variants{["five minutes to"];["five to"]})};
minute56 = {s = mins ["fifty six"] (variants{}) (variants{["four minutes to"];["four to"]})};
minute57 = {s = mins ["fifty seven"] (variants{}) (variants{["three minutes to"];["three to"]})};
minute58 = {s = mins ["fifty eight"] (variants{}) (variants{["two minutes to"];["two to"]})};
minute59 = {s = mins ["fifty nine"] (variants{}) (variants{["one minute to"];["one to"]})};


param RefHour = ThisFormal | ThisLex | NextLex ;
oper refs : Str -> Str -> Str -> RefHour => Str = 
	\x,y,z -> table {ThisFormal => x ; ThisLex => y ; NextLex => z } ; 

lincat Hour = {s : RefHour => Str} ;
lincat Minute = {s : MinMin => Str} ;

param MinMin = Form | Past | To ;
oper mins : Str -> Str -> Str -> MinMin => Str = \x,y,z -> table {Form => x ; Past => y ; To => z } ; 
--oper mins : Str -> Str -> Str -> MinMin => Str = \x,y,z -> table {Form => x ; Past => y ; To => z } ; 
-- jag vill ha en variantsexpanderare, tänk tänk
--oper mins : Str -> Str -> Str -> MinMin => Str = \x,y,z -> table {Form => (variants{x}) ; Past => (variants{y}) ; To => (variants{z}) } ; 
-- Time expressions
lin 

--timeFormal h m = {s = h.s ! ThisFormal ++ m.s ! Form} ;
--timeInformal h m = {s = variants { 
	--m.s ! Past ++ h.s ! ThisLex ; 
	--m.s ! To ++ h.s ! NextLex
	--} 
       --};

time h m = {s = variants { 
	h.s ! ThisFormal ++ m.s ! Form ;
	m.s ! Past ++ h.s ! ThisLex ; 
	m.s ! To ++ h.s ! NextLex
	} 
       };