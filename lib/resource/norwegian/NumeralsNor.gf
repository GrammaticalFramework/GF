-- norsk bokmol, by Herman R Jervell herman.jervell@ilf.uio.no,
-- 6/3/2001

concrete NumeralsNor of Numerals = open Prelude, MorphoNor in {


lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm => Str} ;
lincat Sub100 = {s : Str} ;
lincat Sub1000 = {s : Str} ;
lincat Sub1000000 = {s : Str} ;

lin num x = x ;

lin n2 = mkTal "to"  "tolv"    "tjue" ;
lin n3 = mkTal "tre"  "tretten" "tretti" ;
lin n4 = mkTal "fire" "fjorten" "førti" ;
lin n5 = regTal "fem" ;
lin n6 = regTal "seks" ;
lin n7 = mkTal "sju"  "sytten" "sytti" ;
lin n8 = mkTal "åtte" "atten"   "åtti" ;
lin n9 = mkTal "ni"  "nitten"   "nitti" ;

lin pot01 = {s = table {f => "et"}} ;
lin pot0 d = {s = table {f => d.s ! f}} ;
lin pot110 = ss "ti" ;
lin pot111 = ss "elve" ;
lin pot1to19 d = ss (d.s ! ton) ;
lin pot0as1 n = ss (n.s ! ental) ;
lin pot1 d = ss (d.s ! tiotal) ;
lin pot1plus d e = ss (d.s ! tiotal ++ e.s ! ental) ;
lin pot1as2 n = n ;
lin pot2 d = ss (d.s ! ental ++ "hundre") ;
lin pot2plus d e = ss (d.s ! ental ++ "hundre" ++ "og" ++ e.s) ;
lin pot2as3 n = n ;
lin pot3 n = ss (n.s ++ "tusen") ;
lin pot3plus n m = ss (n.s ++ "tusen" ++ "og" ++ m.s) ;


}