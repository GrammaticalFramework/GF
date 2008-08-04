concrete bulgarian of Numerals = {
flags coding = utf8 ;
-- ä is ya
-- q is [ch]
-- w for [sh]
-- j for i kratkoe i.e i with a thing

-- include numerals.Abs.gf ;
-- flags coding=russian ;

param Size = sg | below10 | tenover ; 
param DForm = unit | teen | ten | hundred ;

oper LinDigit = {s : DForm => Str ; size : Size } ;

lincat Numeral =    { s : Str } ;
lincat Digit =      LinDigit ;     
lincat Sub10 =      LinDigit ;
lincat Sub100 =     {s : Str ; size : Size } ;
lincat Sub1000 =    {s : Str ; size : Size } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> LinDigit = \tri -> \trijset -> \trista -> 
  { s = table {unit => tri ; teen => variants {tri + "надесет" ; tri + "найсет" }; ten => trijset ; hund => trista} ; size = below10};

lin num x = {s = [] ++ x.s ++ []} ; -- the (Russian) Cyrillic ad-hoc translation 

lin n2 = {s = table {unit => "две" ; teen => variants {"дванадесет" ; "дванайсет"}; ten => "двайсет" ; hund => "двеста" } ; size = below10 } ;
lin n3 = mkNum "три" (variants {"трийсет"; "тридесет"}) "триста" ;
lin n4 = mkNum "четири" (variants {"четирисет" ; "четирийсет" ; "четиридесет"}) "четиристотин" ;
lin n5 = mkNum "пет" "петдесет" "петстотин" ;
lin n6 = mkNum "шест" (variants {"шестдесет" ; "шейсет"}) "шестстотин" ;
lin n7 = mkNum "седем" "седемдесет" "седемстотин" ;
lin n8 = mkNum "осем" "осемдесет" "осемстотин" ;
lin n9 = mkNum "девет" "деветдесет" "деветстотин" ;

lin pot01 = { s = table {unit => "едно" ; hundred => "сот" ; _ => "думмю" } ; size = sg };
lin pot0 d = d ;
lin pot110 = {s = "десет" ; size = below10};
lin pot111 = {s = variants {"единадесет" ; "единайсет" }; size = tenover};
lin pot1to19 d = {s = d.s ! teen ; size = tenover};
lin pot0as1 n = {s = n.s ! unit ; size = n.size } ;
lin pot1 d = {s = d.s ! ten ; size = tenover} ;
lin pot1plus d e = {s = d.s ! ten ++ "и" ++ e.s ! unit ; size = tenover} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! hundred ; size = tenover} ;
lin pot2plus d e = { s = d.s ! hundred ++ maybei e.size ++ e.s ; size = tenover } ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = mkThou n.size n.s} ;
lin pot3plus n m = {s = mkThou n.size n.s ++ m.s} ;

oper mkThou : Size -> Str -> Str = \sz -> \attr ->
  table {sg => "жиляда" ; _ => attr ++ "жиляди" } ! sz ;

oper maybei : Size -> Str = \sz -> table {tenover => [] ; _ => "и"} ! sz ; 


}
