concrete NumeralsIta of Numerals = open Prelude, TypesIta, MorphoIta, SyntaxIta in {


lincat 
--Digit = {s : DForm => Str} ;
--lincat Sub10 = {s : DForm => Str ; n : Number} ;
--lincat Sub100 = {s : Str ; n : Number} ;
--lincat Sub1000 = {s : Str ; n : Number} ;
--lincat Sub1000000 = {s : Str} ;
  Numeral = {s : Gender => Str ; n : Number} ;
  Digit = {s : DForm => Str} ;
  Sub10 = {s : DForm => Gender => Str ; n : Number} ;
  Sub100 = {s : Gender => Str ; n : Number} ;
  Sub1000 = {s : Gender => Str ; n : Number} ;
  Sub1000000 = {s : Gender => Str ; n : Number} ;


lin num x = x ;

lin n2 = mkTal "due"  "dodici"    "venti" ;
lin n3 = mkTal "tre"  "tredici" "trenta" ;
lin n4 = mkTal "quattro" "quattordici" "quaranta" ;
lin n5 = mkTal "cinque" "quindici" "cinquanta" ;
lin n6 = mkTal "sei" "sedici" "sessanta" ;
lin n7 = mkTal "sette"  "diciassette" "settanta" ;
lin n8 = mkTal "otto" "diciotto"   "ottanta" ;
lin n9 = mkTal "nove"  "diciannove"   "novanta" ;

lin pot01 = {s = table {
  ental pred => \\_ => [] ; _  => genForms "uno" "una"} ; n = Sg} ;
lin pot0 d = {s =\\f,g => d.s ! f ; n = Pl} ;
lin pot110 = spl "dieci" ;
lin pot111 = spl "undici" ;
lin pot1to19 d = spl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental indip ; n = n.n} ;
lin pot1 d = spl (d.s ! tiotal) ;
lin pot1plus d e = {s = \\g => d.s ! tiotal ++ e.s ! ental indip ! g ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = spl (d.s ! ental pred ! Masc ++ "cento") ;
lin pot2plus d e = {s = \\g => d.s ! ental pred ! Masc ++ "cento" ++ e.s ! g ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = spl (n.s ! Masc ++ mille ! n.n) ;
lin pot3plus n m = {s = \\g => n.s ! Masc ++ mille ! n.n ++ m.s ! g ; n = Pl} ;

}
