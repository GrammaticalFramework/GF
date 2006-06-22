-- norsk bokmol, by Herman R Jervell herman.jervell@ilf.uio.no,
-- 6/3/2001

concrete NumeralsNor of Numerals = open Prelude, TypesNor, MorphoNor in {


lincat Numeral = {s : Gender => Str ; n : Number} ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm => Gender => Str ; n : Number} ;
lincat Sub100 = {s : Gender => Str ; n : Number} ;
lincat Sub1000 = {s : Gender => Str ; n : Number} ;
lincat Sub1000000 = {s : Gender => Str ; n : Number} ;

lin num x = x ;

lin n2 = mkTal "to"  "tolv"    "tjue" ;
lin n3 = mkTal "tre"  "tretten" "tretti" ;
lin n4 = mkTal "fire" "fjorten" "førti" ;
lin n5 = regTal "fem" ;
lin n6 = regTal "seks" ;
lin n7 = mkTal "sju"  "sytten" "sytti" ;
lin n8 = mkTal "åtte" "atten"   "åtti" ;
lin n9 = mkTal "ni"  "nitten"   "nitti" ;

lin pot01 = {s = table {f => table {Neutr => "ett" ; _ => "én"}} ; n = Sg} ;
lin pot0 d = {s = \\f,g => d.s ! f ; n = Pl} ;
lin pot110 = numPl "ti" ;
lin pot111 = numPl "elve" ;
lin pot1to19 d = numPl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental ; n = n.n} ;
lin pot1 d = numPl (d.s ! tiotal) ;
lin pot1plus d e = {s = \\g => d.s ! tiotal ++ e.s ! ental ! g ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = numPl (d.s ! ental ! Neutr ++ "hundre") ;
lin pot2plus d e = {s = \\g => d.s ! ental ! Neutr ++ "hundre" ++ "og" ++ e.s ! g ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = numPl (n.s ! Neutr ++ "tusen") ;
lin pot3plus n m = {s = \\g => n.s ! Neutr ++ "tusen" ++ "og" ++ m.s ! g ; n = Pl} ;


}