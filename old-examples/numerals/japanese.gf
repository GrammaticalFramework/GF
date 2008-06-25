include numerals.Abs.gf ;
flags coding=japanese ;

param DForm = unit | attr | ten | hundred | thousand ; 
param Size = sg | pl | more10 ;
param S100 = tenp | senp ;
param S1000 = indep | man | sen;

-- Standard Romajii
-- Everything should be glued

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str ; size : Size } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ; 
lincat Sub100 = {s : Str ; s2 : S100 => Str; size : Size} ;
lincat Sub1000 = {s : S1000 => Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = "/J" ++ x0.s ++ "J/"} ;

oper mkNum : Str -> LinDigit = \base -> 
  {s = table {unit => base ; attr => base ; ten => base + "juu" ; hundred => base + "hyaku" ; thousand => base + "sen" } ; size = pl} ;

oper mkNum4 : Str -> Str -> Str -> Str -> LinDigit = \ni -> \base -> \nihyaku -> \nisen -> 
  {s = table {unit => ni ; attr => base ; ten => base + "juu" ; hundred => nihyaku ; thousand => nisen } ; size = pl} ;

oper mkNum2 : Str -> Str -> LinDigit = \yon -> \base -> 
  {s = table {unit => yon ; attr => base ; ten => base + "juu" ; hundred => base + "hyaku" ; thousand => base + "sen" } ; size = pl} ;

-- lin n1 = mkNum "ichi" ; 
lin n2 = mkNum "ni" ;
lin n3 = mkNum4 "san" "san" "sanbyaku" "sanzen" ;
lin n4 = mkNum2 (variants { "shi" ; "yon" }) "yon" ;
lin n5 = mkNum "go" ;
lin n6 = mkNum4 "roku" "roku" "roppyaku" "rokusen" ;
lin n7 = mkNum2 (variants {"nana" ; "shichi" }) "nana" ;
lin n8 = mkNum4 "hachi" "hachi" "happyaku" "hassen" ;
lin n9 = mkNum2 (variants {"kyuu" ; "ku" }) "kyuu"  ;

lin pot01  =
  {s = table {unit => "ichi" ; attr => [] ; ten => "juu" ; hundred => "hyaku" ; thousand => "sen"} ; size = sg };
lin pot0 d = d ;
lin pot110 = {s = "juu" ; s2 = table {tenp => "ichi" + "man" ; senp => []} ; size = more10} ;
lin pot111 = {s = "juu" + "ichi" ; s2 = table {tenp => "ichi" + "man" ; senp => "sen"} ; size = more10} ;
lin pot1to19 d = {s = "juu" ++ d.s ! unit ; s2 = table {tenp => "ichi" + "man" ; senp => d.s ! thousand} ; size = more10} ; 
lin pot0as1 n = {s = n.s ! unit ; s2 = table {tenp => [] ; senp => n.s ! thousand} ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; s2 = table {tenp => d.s ! unit ++ "man" ; senp => []} ; size = more10} ;
lin pot1plus d e = 
  {s = d.s ! ten ++ e.s ! unit ;
   s2 = table {tenp => d.s ! unit ++ "man" ; senp => e.s ! thousand} ; 
   size = more10} ; 

lin pot1as2 n = {s = table {indep => n.s ; man => n.s2 ! tenp ++ n.s2 ! senp ; sen => n.s2 ! senp} ; size = n.size} ;
lin pot2 d = {s = table {indep => d.s ! hundred ; man => d.s ! ten ++ "man" ; sen => "dummy"} ; size = more10 };
lin pot2plus d e = {s = table {indep => d.s ! hundred ++ e.s ; man => d.s ! ten ++ e.s2 ! tenp ++ e.s2 ! senp ; sen => "dummy" } ; size = more10 };
lin pot2as3 n = {s = n.s ! indep } ;
lin pot3 n = {s = table {more10 => n.s ! man ; _ => n.s ! sen} ! n.size} ;
lin pot3plus n m = {s = table {more10 => n.s ! man ; _ => n.s ! sen} ! n.size ++ m.s ! indep} ;

