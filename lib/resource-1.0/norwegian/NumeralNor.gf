concrete NumeralNor of Numeral = CatNor ** open MorphoNor in {

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100, Sub1000, Sub1000000 = 
          {s :          CardOrd => Str ; n : Number} ;

lin 
  num x = x ;

  n2 = mkTal "to"   "tolv"    "tjue"   "andre"   "tolfte" ;
  n3 = mkTal "tre"  "tretten" "tretti" "tredje"  "trettende" ;
  n4 = mkTal "fire" "fjorten" "førti"  "fjerde"  "fjortende" ;
  n5 = mkTal "fem"  "femten"  "femti"  "femte"   "femtende" ;
  n6 = mkTal "seks" "seksten" "seksti" "sjette"  "sextende" ;
  n7 = mkTal "sju"  "sytten"  "sytti"  "syvende" "syttende" ;
  n8 = mkTal "åtte" "atten"   "åtti"   "åttende" "attende" ;
  n9 = mkTal "ni"   "nitten"  "nitti"  "niende"  "nittende" ;

  pot01 = {
    s = \\f => table {
          NCard g => case g of {Neutr => "ett" ; _ => "en"} ;
          _ => "første"
          } ; 
    n = Sg
    } ;
  pot0 d = {s = \\f,g => d.s ! f ! g ; n = Pl} ;
  pot110 = numPl (cardReg "ti") ;
  pot111 = numPl (cardOrd "elve" "elfte") ;
  pot1to19 d = numPl (d.s ! ton) ;
  pot0as1 n = {s = n.s ! ental ; n = n.n} ;
  pot1 d = numPl (d.s ! tiotal) ;
  pot1plus d e = {s = \\g => d.s ! tiotal ! invNum ++ e.s ! ental ! g ; n = Pl} ;
  pot1as2 n = n ;
  pot2 d = 
    numPl (\\g => d.s ! ental ! invNum ++ cardOrd "hundre" "hundrede" ! g) ;
  pot2plus d e = 
    {s = \\g => d.s ! ental ! invNum ++ "hundre" ++ "og" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
  pot3 n = 
    numPl (\\g => n.s ! invNum ++ cardOrd "tusen" "tusende" ! g) ;
  pot3plus n m = 
    {s = \\g => n.s ! invNum ++ "tusen" ++ "og" ++ m.s ! g ; n = Pl} ;

}

