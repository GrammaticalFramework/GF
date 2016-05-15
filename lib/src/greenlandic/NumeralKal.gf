--# -path=.:../abstract

concrete NumeralKal of Numeral = {

-- AR 15/5/2016 following Bjørnum, Grønlandsk grammatik

---- starting with a reduced case system

lincat
  Numeral, Sub10, Sub100, Sub1000, Sub1000000 = {s : NumForm => Str} ;
  Digit = {s,teen : NumForm => Str} ;

param
  NumForm = NAbs | NInstr | NOrd ;
oper
  mkNumeral : (abs,instr,ord : Str) -> Numeral
    = \abs,instr,ord -> lin Numeral {s = table {NAbs => abs ; NInstr => instr ; NOrd => ord}} ;

  under6Digit : (abs, instr, ord, teenord : Str) -> Digit
    = \abs, instr, ord, teenord ->
       lin Digit (
         mkNumeral abs instr ord **
         {teen = table {NOrd => teenord ; nf => aqqaneq ++ (mkNumeral abs instr ord).s ! nf} ;
         }
       ) ;
       
  over6Digit : Digit -> Str -> Digit
    = \d,teenord ->
      lin Digit {
        s = \\nf => arfineq ++ d.s ! nf ;
        teen = table {NOrd => teenord ; nf => arfersaneq ++ d.s ! nf}
      } ;

oper
  aqqaneq    = "aqqaneq-"    ++ Predef.BIND ;
  arfineq    = "arfineq-"    ++ Predef.BIND ;
  arfersaneq = "arfersaneq-" ++ Predef.BIND ;


lin num x = x ;

lin n2 = under6Digit   "marluk"      "marlunnik"   "aappaat"    "aqqaneq-aappaat" ;
lin n3 = under6Digit   "pingasut"    "pingasunik"  "pingajuat"  "tretteniat" ;
lin n4 = under6Digit   "sisamat"     "sisamanik"   "sisamaat"   "fjorteniat" ;
lin n5 = under6Digit   "tallimat"    "tallimanik"  "tallimaat"  "femteniat" ;
lin n6 = mkNumeral "arfinillit"  "arfinillik"  "arferngat"  ** {teen = \\nf => (mkNumeral "arfersanillit" "arfersanillik" "seksteniat").s ! nf} ;
lin n7 = over6Digit n2 "sytteniat" ;
lin n8 = over6Digit n3 "atteniat" ;
lin n9 = over6Digit n4 "nitteniat" ;   ---- qulingiluat, qulaaluat

lin pot01 = mkNumeral "ataaseq" "ataatsimik" "siulliat" ;

lin pot0 d = d ;
lin pot110 = mkNumeral "qulit" "qulinik" "qulingat" ;
lin pot111 = mkNumeral "aqqanillit" "aqqanillik" "aqqarngat" ; ---- isikkanillit
lin pot1to19 d = {s = d.teen} ;
lin pot0as1 n = n ;
lin pot1 d = {s = \\nf => d.s ! NInstr ++ "qulillit"} ;  ---- inflection of qulillit

----  pot1plus d e = {s = \\g => e.s ! ental ! invNum ++ "og" ++ d.s ! tiotal ! g ; n = Pl} ;
  pot1as2 n = n ;
----  pot2 d = numPl (\\_ => d.s ! ental ! invNum ++ "hundrede") ;
----  pot2plus d e = {s = \\g => d.s ! ental ! invNum ++ "hundrede" ++ "og" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
----  pot3 n = numPl (\\g => n.s ! invNum ++ cardOrd "tusind" "tusinde" ! g) ;
----  pot3plus n m = {s = \\g => n.s ! invNum ++ "tusind" ++ "og" ++ m.s ! g ; n =Pl} ;


{-
  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ; 

    IIDig d i = {
      s = \\o => d.s ! NCard neutrum ++ BIND ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1:e" Sg ;
    D_2 = mk2Dig "2" "2:e" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + ":e") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
      s = table {NCard _ => c ; NOrd _ => o} ;
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;
-}

}
