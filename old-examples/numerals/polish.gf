-- numerals in Polish, author Wojciech Mostowski, 20/9/2002

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

lincat Numeral =    { s : Str } ;
lincat Digit =      LinDigit ;
lincat Sub10 =      {s : DForm => Str; o : ThForm ; t : ThForm } ;
lincat Sub100 =     {s : Str; t : ThForm } ;
lincat Sub1000 =    {s : Str; t : ThForm } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> Str -> ThForm -> LinDigit = 
  \dwa -> \dwanascie -> \dwadziescia -> \dwiescie -> \thform ->
  { s = table {unit => dwa ; teen => dwanascie ; ten => dwadziescia ; hund =>
dwiescie  };
    o =  thform ; t = thform
  };

oper mkRegNum1 : Str -> LinDigit = 
  \siedem -> 
  { s = table { unit => siedem ; teen => siedem + "nascie" ; 
                ten => siedem + "dziesiat" ; hund => siedem + "set"
              };
    o =  fiveup ; t = fiveup
  };
oper mkRegNum2 : Str -> LinDigit = 
  \pie -> 
  { s = table { unit => pie + "c" ; teen => pie + "tnascie" ; 
                ten => pie + "cdziesiat" ; hund => pie + "cset"
              };
    o =  fiveup ; t = fiveup
  };

oper mkTh : ThForm => Str = 
  table { onlyone => "tysiac" ; lastone => "tysiecy" ;
          twoorthreeorfour => "tysiace" ; fiveup => "tysiecy"
        }; 

oper ss : Str -> ThForm -> {s : Str ; t : ThForm} = \str -> \th -> {s = str; t = th}
;

lin num x = x ;

lin n2 = mkNum "dwa"      "dwanascie"      "dwadziescia"      "dwiescie"   
twoorthreeorfour ;
lin n3 = mkNum "trzy"     "trzynascie"     "trzydziesci"      "trzysta"    
twoorthreeorfour ;
lin n4 = mkNum "cztery"   "czternascie"    "czterdziesci"     "czterysta"  
twoorthreeorfour ;
lin n5 = mkRegNum2 "pie" ;
lin n6 = mkNum "szesc"    "szesnascie"     "szescdziesiat"    "szescset"    fiveup;
lin n7 = mkRegNum1 "siedem" ;
lin n8 = mkRegNum1 "osiem" ;
lin n9 = mkRegNum2 "dziewie" ;

lin pot01 = { s = table {hund => "sto"; f => "jeden" };
              o = onlyone ; t = lastone
            };
lin pot0 d = {s = table {f => d.s ! f} ; o = d.o ; t = d.t} ;
lin pot110 = ss "dziesiec" fiveup ;
lin pot111 = ss "jedenascie" fiveup ;
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
lin pot3 n = {s = n.s ++ mkTh ! n.t} ;
lin pot3plus n m = {s = n.s ++ mkTh ! n.t ++ m.s} ;

