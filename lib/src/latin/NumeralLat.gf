concrete NumeralLat of Numeral = CatLat ** open ResLat in {
--
--lincat 
--  Digit = {s : DForm => CardOrd => Str} ;
--  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
--  Sub100     = {s : CardOrd => Str ; n : Number} ;
--  Sub1000    = {s : CardOrd => Str ; n : Number} ;
--  Sub1000000 = {s : CardOrd => Str ; n : Number} ;
--
--lin num x = x ;
--lin n2 = let two = mkNum "two"   "twelve"   "twenty" "second" in
--         {s = \\f,c => case <f,c> of {
--             <teen,NOrd> => "twelfth" ;
--             _ => two.s ! f ! c
--             }
--         } ;
--
--lin n3 = mkNum "three" "thirteen" "thirty" "third" ;
--lin n4 = mkNum "four"  "fourteen" "forty" "fourth" ;
--lin n5 = mkNum "five"  "fifteen"  "fifty" "fifth" ;
--lin n6 = regNum "six" ;
--lin n7 = regNum "seven" ;
--lin n8 = mkNum "eight" "eighteen" "eighty" "eighth" ;
--lin n9 = mkNum "nine" "nineteen" "ninety" "ninth" ;
--
--lin pot01 = mkNum "one" "eleven" "ten" "first" ** {n = Sg} ;
--lin pot0 d = d ** {n = Pl} ;
--lin pot110 = regCardOrd "ten" ** {n = Pl} ;
--lin pot111 = regCardOrd "eleven" ** {n = Pl} ;
--lin pot1to19 d = {s = d.s ! teen} ** {n = Pl} ;
--lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
--lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;
--lin pot1plus d e = {
--   s = \\c => d.s ! ten ! NCard ++ "-" ++ e.s ! unit ! c ; n = Pl} ;
--lin pot1as2 n = n ;
--lin pot2 d = {s = \\c => d.s ! unit ! NCard ++ mkCard c "hundred"}  ** {n = Pl} ;
--lin pot2plus d e = {
--  s = \\c => d.s ! unit ! NCard ++ "hundred" ++ "and" ++ e.s ! c ; n = Pl} ;
--lin pot2as3 n = n ;
--lin pot3 n = {
--  s = \\c => n.s ! NCard ++ mkCard c "thousand" ; n = Pl} ;
--lin pot3plus n m = {
--  s = \\c => n.s ! NCard ++ "thousand" ++ m.s ! c ; n = Pl} ;
--
-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = {s = d.s ! one; unit = ten} ;

    IIDig d i = {
      s = d.s ! i.unit ++ i.s ;
      unit = inc i.unit
    } ;

    D_0 = mkDig ""     ""     ""     ""       ""       "" ;
    D_1 = mkDig "I"    "X"    "C"    "M"      "(X)"    "(C)" ;
    D_2 = mkDig "II"   "XX"   "CC"   "MM"     "(XX)"   "(CC)" ;
    D_3 = mkDig "III"  "XXX"  "CCC"  "MMM"    "(XXX)"  "(CCC)" ;
    D_4 = mkDig "IV"   "XL"   "CD"   "(IV)"   "(XL)"   "(CD)" ;
    D_5 = mkDig "V"    "L"    "D"    "(V)"    "(L)"    "(D)" ;
    D_6 = mkDig "VI"   "LX"   "DC"   "(VI)"   "(LX)"   "(DC)" ;
    D_7 = mkDig "VII"  "LXX"  "DCC"  "(VII)"  "(LXX)"  "(DCC)" ;
    D_8 = mkDig "VIII" "LXXX" "DCCC" "(VIII)" "(LXXX)" "(DCCC)" ;
    D_9 = mkDig "IX"   "XC"   "CM"   "(IX)"   "(XC)"   "(CM)" ;

  oper
    TDigit = {
      s : Unit => Str
    } ;

    mkDig : Str -> Str -> Str -> Str -> Str -> Str -> TDigit = 
      \one,ten,hundred,thousand,ten_thousand,hundred_thousand -> {
          s = table Unit [one;ten;hundred;thousand;ten_thousand;hundred_thousand]
        } ;
        
    inc : Unit -> Unit = \u ->
      case u of {
        one              => ten ;
        ten              => hundred ;
        hundred          => thousand ;
        thousand         => ten_thousand ;
        ten_thousand     => hundred_thousand ;
        hundred_thousand => hundred_thousand
      } ;
}
