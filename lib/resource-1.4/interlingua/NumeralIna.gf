concrete NumeralIna of Numeral = CatIna ** open ResIna in {

  lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100     = {s : CardOrd => Str ; n : Number} ;
  Sub1000    = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

  lin num x = x ;

  lin n2 = mkNum  "duo"    "secunde" "vinti" "vintesime";
  lin n3 = mkNum  "tres"   "tertie" "trenta" "trentesime";
  lin n4 = mkNum  "quatro" "quarte" "quaranta" "quarantesime";
  lin n5 = regNum "cinque" "quinte"  ;
  lin n6 = regNum "sex"    "sexte"   ;
  lin n7 = regNum "septe"  "septime" ;
  lin n8 = regNum "octo"   "octave"  ;
  lin n9 = regNum "novem"  "none"    ;

  lin pot01 = mkNum "un" "prime" "dece" "decime" ** {n = Sg} ;
  lin pot0 d = d ** {n = Pl} ;
  lin pot110 = regCardOrd "dece" ** {n = Pl} ;
  lin pot111 = regCardOrd ["dece-un"] ** {n = Pl} ;
  lin pot1to19 d = {s = \\c => "dece" ++ "-" ++ d.s ! unit ! c} ** {n = Pl} ;
  lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
  lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;
  lin pot1plus d e = {
	s = \\c => d.s ! ten ! NCard ++ "-" ++ e.s ! unit ! c ; n = Pl} ;
  lin pot1as2 n = n ;
  lin pot2 d = {s = \\c => d.s ! unit ! NCard ++ mkCard c "cento"}  ** {n = Pl} ;
  lin pot2plus d e = {
	s = \\c => d.s ! unit ! NCard ++ "cento" ++ e.s ! c ; n = Pl} ;
  lin pot2as3 n = n ;
  lin pot3 n = {
	s = \\c => n.s ! NCard ++ mkCard c "mille" ; n = Pl} ;
  lin pot3plus n m = {
	s = \\c => n.s ! NCard ++ "mille" ++ m.s ! c ; n = Pl} ;

-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ** {tail = T1} ;

    IIDig d i = {
      s = \\o => d.s ! NCard ++ commaIf i.tail ++ i.s ! o ;
      n = Pl ;
      tail = inc i.tail
    } ;

    -- I don't know the convention (and could not find it in the
    -- grammar) so I just affix "e" to all numbers to indicate the
    -- ordinal

    D_0 = mkDig "0" ;
    D_1 = mkDig "1" ;
    D_2 = mkDig "2" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    commaIf : DTail -> Str = \t -> case t of {
      T3 => "," ;
      _ => []
      } ;

    inc : DTail -> DTail = \t -> case t of {
      T1 => T2 ;
      T2 => T3 ;
      T3 => T1
      } ;

    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "e") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
      s = table {NCard => c ; NOrd => o} ;
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;

}
