concrete NumeralsSwe of Numerals = open MorphoSwe, Prelude in {

lincat 
  Numeral = {s : Gender => Str ; n : Number} ;
  Digit = {s : DForm => Str} ;
  Sub10 = {s : DForm => Gender => Str ; n : Number} ;
  Sub100 = {s : Gender => Str ; n : Number} ;
  Sub1000 = {s : Gender => Str ; n : Number} ;
  Sub1000000 = {s : Gender => Str ; n : Number} ;

lin 
  num x = x ;

  n2 = mkTal  "två"  "tolv"    "tjugo" ;
  n3 = mkTal  "tre"  "tretton" "trettio" ;
  n4 = mkTal  "fyra" "fjorton" "fyrtio" ;
  n5 = regTal "fem" ;
  n6 = regTal "sex" ;
  n7 = mkTal  "sju"  "sjutton" "sjuttio" ;
  n8 = mkTal  "åtta" "arton"   "åttio" ;
  n9 = mkTal  "nio"  "nitton"   "nittio" ;

  pot01 = {s = table {f => table {Neutr => "ett" ; _ => "en"}} ; n = Sg} ;
  pot0 d = {s = \\f,g => d.s ! f ; n = Pl} ;
  pot110 = numPl "tio" ;
  pot111 = numPl "elva" ;
  pot1to19 d = numPl (d.s ! ton) ;
  pot0as1 n = {s = n.s ! ental ; n = n.n} ;
  pot1 d = numPl (d.s ! tiotal) ;
  pot1plus d e = {s = \\g => d.s ! tiotal ++ e.s ! ental ! g ; n = Pl} ;
  pot1as2 n = n ;
  pot2 d = numPl (d.s ! ental ! Neutr ++ "hundra") ;
  pot2plus d e = {s = \\g => d.s ! ental ! Neutr ++ "hundra" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
  pot3 n = numPl (n.s ! Neutr ++ "tusen") ;
  pot3plus n m = {s = \\g => n.s ! Neutr ++ "tusen" ++ m.s ! g ; n = Pl} ;

}
