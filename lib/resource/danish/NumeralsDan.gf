-- AR 12/10/2002 following www.geocities.com/tsca.geo/dansk/dknummer.html

concrete NumeralsDan of Numerals = open Prelude, TypesDan, MorphoDan in {

lincat 
  Numeral = {s : Gender => Str ; n : Number} ;
  Digit = {s : DForm => Str} ;
  Sub10 = {s : DForm => Gender => Str ; n : Number} ;
  Sub100 = {s : Gender => Str ; n : Number} ;
  Sub1000 = {s : Gender => Str ; n : Number} ;
  Sub1000000 = {s : Gender => Str ; n : Number} ;

lin num x = x ;

lin n2 = mkTal "to"   "tolv"    "tyve" ;
lin n3 = mkTal "tre"  "tretten" "tredive" ;
lin n4 = mkTal "fire" "fjorten" "fyrre" ;
lin n5 = mkTal "fem"  "femten"  "halvtreds" ;
lin n6 = mkTal "seks" "seksten" "tres" ;
lin n7 = mkTal "syv"  "sytten"  "halvfjerds" ;
lin n8 = mkTal "otte" "atten"   "firs" ;
lin n9 = mkTal "ni"   "nitten"  "halvfems" ;

  pot01 = {s = table {f => table {Neutr => "et" ; _ => "en"}} ; n = Sg} ;
  pot0 d = {s = \\f,g => d.s ! f ; n = Pl} ;
  pot110 = numPl "ti" ;
  pot111 = numPl "elleve" ;
  pot1to19 d = numPl (d.s ! ton) ;
  pot0as1 n = {s = n.s ! ental ; n = n.n} ;
  pot1 d = numPl (d.s ! tiotal) ;
  pot1plus d e = {s = \\g => e.s ! ental ! g ++ "og" ++ d.s ! tiotal ; n = Pl} ;
  pot1as2 n = n ;
  pot2 d = numPl (d.s ! ental ! Neutr ++ "hundrede") ;
  pot2plus d e = 
    {s = \\g => d.s ! ental ! Neutr ++ "hundrede" ++ "og" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
  pot3 n = numPl (n.s ! Neutr ++ "tusind") ;
  pot3plus n m = {s = \\g => n.s ! Neutr ++ "tusind" ++ "og" ++ m.s ! g ; n = Pl} ;

}