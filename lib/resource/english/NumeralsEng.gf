concrete NumeralsEng of Numerals = open Prelude, MorphoEng in {

lincat Numeral = {s : Str ; n : Number} ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm => Str ; n : Number} ;
  Sub100 = {s : Str ; n : Number} ;
  Sub1000 = {s : Str ; n : Number} ;
  Sub1000000 = {s : Str ; n : Number} ;

lin num x = x ;
lin n2 = mkNum "two"   "twelve"   "twenty" ;
lin n3 = mkNum "three" "thirteen" "thirty" ;
lin n4 = mkNum "four"  "fourteen" "forty" ;
lin n5 = mkNum "five"  "fifteen"  "fifty" ;
lin n6 = regNum "six" ;
lin n7 = regNum "seven" ;
lin n8 = mkNum "eight" "eighteen" "eighty" ;
lin n9 = regNum "nine" ;

lin pot01 = {s = table {f => "one"} ; n = Sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; n = Pl} ;
lin pot110 = ss "ten" ** {n = Pl} ;
lin pot111 = ss "eleven" ** {n = Pl} ;
lin pot1to19 d = {s = d.s ! teen} ** {n = Pl} ;
lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;
lin pot1plus d e = {s = d.s ! ten ++ "-" ++ e.s ! unit} ** {n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! unit ++ "hundred"}  ** {n = Pl} ;
lin pot2plus d e = {s = d.s ! unit ++ "hundred" ++ "and" ++ e.s} ** {n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = {s = n.s ++ "thousand"}  ** {n = Pl} ;
lin pot3plus n m = {s = n.s ++ "thousand" ++ m.s}  ** {n = Pl} ;

}
