concrete NumeralGer of Numeral = CatGer ** open MorphoGer in {

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str} ;
  Sub100, Sub1000, Sub1000000 = 
          {s :          CardOrd => Str} ;

lin 
  num x = x ;

  n2 = mkDigit  "zwei"  "zwölf"   "zwanzig"   "zweite" ;
  n3 = mkDigit  "drei"  "dreizehn" "dreissig" "dritte" ;
  n4 = regDigit  "vier" ;
  n5 = regDigit  "fünf" ;
  n6 = regDigit  "sechs" ;
  n7 = mkDigit  "sieben"  "siebzehn" "siebzig" "siebte" ;
  n8 = mkDigit  "acht" "achzehn"   "achzig"   "achte" ;
  n9 = regDigit  "neun" ;

  pot01 = {
    s = \\f => table {
          NCard => "ein" ; ----
          NOrd af => (regA "erst").s ! Posit ! af
          } ; 
    n = Sg
    } ;
  pot0 d = {s = \\f,g => d.s ! f ! g ; n = Pl} ;
  pot110 = {s = cardReg "zehn"} ;
  pot111 = {s = cardReg "elf"} ;
  pot1to19 d = {s = d.s ! DTeen} ;
  pot0as1 n = {s = n.s ! DUnit} ;
  pot1 d = {s = d.s ! DTen} ;
  pot1plus d e = {s = \\g => e.s ! DUnit ! invNum ++ "und" ++ d.s ! DTen ! g} ;
  pot1as2 n = n ;
  pot2 d = 
    {s = \\g => d.s ! DUnit ! invNum ++ cardOrd "hundert" "hunderte" ! g} ;
  pot2plus d e = 
    {s = \\g => d.s ! DUnit ! invNum ++ "hundert" ++ e.s ! g} ;
  pot2as3 n = n ;
  pot3 n = 
    {s = \\g => n.s ! invNum ++ cardOrd "tausend" "tausendte" ! g} ; ----
  pot3plus n m = 
    {s = \\g => n.s ! invNum ++ "tausend" ++ m.s ! g ; n = Pl} ;

}