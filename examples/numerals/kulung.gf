include numerals.Abs.gf ;

param DForm = basic | belowtenform | tenindep | ten;
param Size = sg | less100 | more100 ;
param Scale = reg | lakh ; 

-- From Krishna Bahadur Rai in Werner Winter: When Numeral Systems are
-- Expanded in Jadranka Gvozdanovic' (ed.) Numeral Types and Changes
-- Worldwide, 1999 

lincat Numeral =    { s : Str } ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Scale => Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> Str -> Lin Digit = 
  \two -> \two2 -> \twenty -> \twenty2 ->  
  {s = table {basic => two ; belowtenform => two2 ; tenindep => twenty ; ten => twenty2}} ;

oper mkRegNum : Str -> Lin Digit = 
  \su -> 
  { s = table { basic => su ; belowtenform => su + "kci" ; tenindep => su + "kká" ; ten => su + "k"} }; 

lin num x = x ;
-- lin n1 mkNum "i" "ibim" ... ;
lin n2 = mkNum "ni" "nicci" (variants { "nissá" ; "nukká" }) "nuk" ; 
lin n3 = mkRegNum "su" ;
lin n4 = mkNum "li" "lici" "likká" "lik" ;
lin n5 = mkNum "ngá" "ngá" "ngakká" "ngak" ;
lin n6 = mkRegNum "tu" ;
lin n7 = mkRegNum "nu" ;
lin n8 = mkRegNum "re" ;
lin n9 = mkNum "vau" "vauci" "vavau" "vavau" ;

oper ss : Str -> {s : Str ; size : Size} = \s -> {s = s ; size = less100} ;

lin pot01 = {s = table {f => variants {"i" ; "ibim"}} ; size = sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; size = less100} ;
lin pot110 = ss ( variants { "pau" ; "pauci" }) ; 
lin pot111 = ss ("pau" ++ "i") ;
lin pot1to19 d = ss ("pau" ++ d.s ! basic) ;
lin pot0as1 n = {s = variants {n.s ! basic ; n.s ! belowtenform} ; size = n.size} ;
lin pot1 d = {s = d.s ! tenindep ; size = less100} ;
lin pot1plus d e = {s = (d.s ! ten) ++ e.s ! basic ; size = less100} ;
lin pot1as2 n = {s = table {_ => n.s } ; size = n.size} ;
lin pot2 d = {s = table {lakh => omitsg (d.s ! basic) d.size ++ "lankau" ; reg => omitsg (d.s ! basic) d.size ++ "chhum" }; size = more100} ;
lin pot2plus d e = {s = table {lakh => omitsg (d.s ! basic) d.size ++ "lankau" ++ omitsg e.s e.size ++ "habau" ; reg => omitsg (d.s ! basic) d.size ++ "chhum" ++ e.s } ; size = more100} ;

lin pot2as3 n = {s = n.s ! reg };
lin pot3 n = {s = mklankau n.size (n.s ! reg) (n.s ! lakh)} ;
lin pot3plus n m = {s = mklankau n.size (n.s ! reg) (n.s ! lakh) ++ m.s ! reg} ;

oper mklankau : Size -> Str -> Str -> Str = \sz -> \attr -> \lankau ->
  table {sg => "habau" ; less100 => attr ++ "habau" ; more100 => lankau} ! sz; 
oper omitsg : Str -> Size -> Str = \s -> \sz -> table {sg => [] ; _ => s} ! sz ; 