concrete NumeralSwe of Numeral = CatSwe ** open ResScand, MorphoSwe in {

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100, Sub1000, Sub1000000 = 
          {s :          CardOrd => Str ; n : Number} ;

lin 
  num x = x ;

  n2 = mkTal  "två"  "tolv"    "tjugo"   "andra"   "tolfte" ;
  n3 = mkTal  "tre"  "tretton" "trettio" "tredje"  "trettonde" ;
  n4 = mkTal  "fyra" "fjorton" "fyrtio"  "fjärde"  "fjortonde" ;
  n5 = mkTal  "fem"  "femton"  "femtio"  "femte"   "femtonde" ;
  n6 = mkTal  "sex"  "sexton"  "sextion" "sjätte"  "sextonde" ;
  n7 = mkTal  "sju"  "sjutton" "sjuttio" "sjunde"  "sjuttonde" ;
  n8 = mkTal  "åtta" "arton"   "åttio"   "åttonde" "artonde" ;
  n9 = mkTal  "nio"  "nitton"  "nittio"  "nionde"  "nittonde" ;

  pot01 = {
    s = \\f => table {
          NCard g => case g of {Neutr => "ett" ; _ => "en"} ;
          _ => "första"
          } ; 
    n = Sg
    } ;
  pot0 d = {s = \\f,g => d.s ! f ! g ; n = Pl} ;
  pot110 = numPl (cardReg "tio") ;
  pot111 = numPl (cardOrd "elva" "elfte") ;
  pot1to19 d = numPl (d.s ! ton) ;
  pot0as1 n = {s = n.s ! ental ; n = n.n} ;
  pot1 d = numPl (d.s ! tiotal) ;
  pot1plus d e = {s = \\g => d.s ! tiotal ! invNum ++ e.s ! ental ! g ; n = Pl} ;
  pot1as2 n = n ;
  pot2 d = 
    numPl (\\g => d.s ! ental ! invNum ++ cardOrd "hundra" "hundrade" ! g) ;
  pot2plus d e = 
    {s = \\g => d.s ! ental ! invNum ++ "hundra" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
  pot3 n = 
    numPl (\\g => n.s ! invNum ++ "tusen" ++ cardOrd "tusen" "tusende" ! g) ;
  pot3plus n m = 
    {s = \\g => n.s ! invNum ++ "tusen" ++ m.s ! g ; n = Pl} ;

}

