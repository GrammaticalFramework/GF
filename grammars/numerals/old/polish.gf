-- numerals in Polish, author Wojciech Mostowski, 20/9/2002

-- Did special Polish characters Harald Hammarstrom October 2003
-- e,  for e,
-- c' for c'
-- s' for s'
-- a, for a,
-- l/ for l/
-- n' for n'
-- z. for z.


include numerals.Abs.gf ;

-- all different for unit digits, teens, tens and hundreds
param DForm = unit  | teen  | ten | hund ;

-- cases for thousand in Polish
-- 1000 - jeden TYSIAC
-- 2000 - dwa TYSIACE
-- 3000 - trzy TYSIACE
-- 4000 - cztery TYSIACE
-- 5000 - piec TYSIECY
-- 104000 - sto cztery TYSIECE
-- 105000 - sto piec TYSIECY
-- 24000 - dwadziescia cztery TYSIACE
-- 25000 - dwadziescia piec TYSIACY
-- BUT e.g.
-- 21000 - dwadziescia jeden TYSIECY (not TYSIAC)
-- 11000 - jedenascie TYSIECY
-- (12..19)000 - TYSIECY

param ThForm = onlyone | lastone | twoorthreeorfour | fiveup ;

oper LinDigit = {s : DForm => Str; o : ThForm ; t : ThForm } ;
lincat Digit =      LinDigit ;
lincat Sub10 =      {s : DForm => Str; o : ThForm ; t : ThForm } ;
lincat Sub100 =     {s : Str; t : ThForm } ;
lincat Sub1000 =    {s : Str; t : ThForm } ;

oper mkNum : Str -> Str -> Str -> Str -> ThForm -> LinDigit = 
  \dwa -> \dwanascie -> \dwadziescia -> \dwiescie -> \thform ->
  { s = table {unit => dwa ; teen => dwanascie ; ten => dwadziescia ; hund =>
dwiescie  };
    o =  thform ; t = thform
  };

oper mkRegNum1 : Str -> LinDigit = 
  \siedem -> 
  { s = table { unit => siedem ; teen => siedem + "nas'cie" ; 
                ten => siedem + "dziesia,t" ; hund => siedem + "set"
              };
    o =  fiveup ; t = fiveup
  };
oper mkRegNum2 : Str -> LinDigit = 
  \pie -> 
  { s = table { unit => pie + "c'" ; teen => pie + "tnas'cie" ; 
                ten => pie + "c'dziesia,t" ; hund => pie + "c'set"
              };
    o =  fiveup ; t = fiveup
  };

oper mkTh : Str -> ThForm => Str = \s -> 
  table { onlyone => "tysia,c" ; lastone => s ++ "tysie,cy" ;
          twoorthreeorfour => s ++ "tysia,ce" ; fiveup => s ++ "tysie,cy"
        }; 

oper ss : Str -> ThForm -> {s : Str ; t : ThForm} = \str -> \th -> {s = str; t = th}
;

lin num x = {s = "/L" ++ x.s ++ "L/"} ; -- the Polish in Latin A supplement ;

lin n2 = mkNum "dwa"      "dwanas'cie"      "dwadzies'cia"      "dwies'cie"   
twoorthreeorfour ;
lin n3 = mkNum "trzy"     "trzynas'cie"     "trzydzies'ci"      "trzysta"    
twoorthreeorfour ;
lin n4 = mkNum "cztery"   "czternas'cie"    (variants {"czterydzies'ci" ; "czterdzies'ci"})     "czterysta"  
twoorthreeorfour ;
lin n5 = mkRegNum2 "pie," ;
lin n6 = mkNum "szes'c'"    "szesnas'cie"     "szes'c'dziesia,t"    "szes'c'set"    fiveup;
lin n7 = mkRegNum1 "siedem" ;
lin n8 = mkRegNum1 "osiem" ;
lin n9 = mkRegNum2 "dziewie," ;

lin pot01 = { s = table {hund => "sto"; f => "jeden" };
              o = onlyone ; t = lastone
            };
lin pot0 d = {s = table {f => d.s ! f} ; o = d.o ; t = d.t} ;
lin pot110 = ss "dziesie,c'" fiveup ;
lin pot111 = ss "jedenas'cie" fiveup ;
lin pot1to19 d = {s = d.s ! teen ; t = fiveup} ;
lin pot0as1 n = {s = n.s ! unit ; t = n.o} ;
lin pot1 d = {s = d.s ! ten ; t = fiveup} ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit; t = e.t} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! hund ; t = fiveup} ;
lin pot2plus d e = { s = d.s ! hund ++ e.s ; 
                     t = table { onlyone => lastone ; f =>  f } ! e.t 
                   } ;

lin pot2as3 n = n ;
lin pot3 n = {s = (mkTh n.s) ! n.t} ;
lin pot3plus n m = {s = (mkTh n.s) ! n.t ++ m.s} ;

