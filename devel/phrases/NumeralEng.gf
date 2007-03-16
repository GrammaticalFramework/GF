--# -path=.:prelude

concrete NumeralEng of Numeral = open Prelude in {

lincat 
    Numeral = {s : Str} ; ---{s : CardOrd => Str ; n : Num} ;
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Num} ;
  Sub100     = {s : CardOrd => Str ; n : Num} ;
  Sub1000    = {s : CardOrd => Str ; n : Num} ;
  Sub1000000 = {s : CardOrd => Str ; n : Num} ;

lin num x = {s = x.s ! NCard} ; ----
lin n2 = let two = mkNum "two"   "twelve"   "twenty" "second" in
         {s = \\f,c => case <f,c> of {
             <teen,NOrd> => "twelfth" ;
             _ => two.s ! f ! c
             }
         } ;

lin n3 = mkNum "three" "thirteen" "thirty" "third" ;
lin n4 = mkNum "four"  "fourteen" "forty" "fourth" ;
lin n5 = mkNum "five"  "fifteen"  "fifty" "fifth" ;
lin n6 = regNum "six" ;
lin n7 = regNum "seven" ;
lin n8 = mkNum "eight" "eighteen" "eighty" "eighth" ;
lin n9 = mkNum "nine" "nineteen" "ninety" "ninth" ;

lin pot01 = mkNum "one" "eleven" "ten" "first" ** {n = Sg} ;
lin pot0 d = d ** {n = Pl} ;
lin pot110 = regCardOrd "ten" ** {n = Pl} ;
lin pot111 = regCardOrd "eleven" ** {n = Pl} ;
lin pot1to19 d = {s = d.s ! teen} ** {n = Pl} ;
lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;
lin pot1plus d e = {
   s = \\c => d.s ! ten ! NCard ++ "-" ++ e.s ! unit ! c ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = \\c => d.s ! unit ! NCard ++ mkCard c "hundred"}  ** {n = Pl} ;
lin pot2plus d e = {
  s = \\c => d.s ! unit ! NCard ++ "hundred" ++ "and" ++ e.s ! c ; n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = {
  s = \\c => n.s ! NCard ++ mkCard c "thousand" ; n = Pl} ;
lin pot3plus n m = {
  s = \\c => n.s ! NCard ++ "thousand" ++ m.s ! c ; n = Pl} ;

oper
  mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
    \two, twelve, twenty, second ->
    {s = table {
       unit => table {NCard => two ; NOrd => second} ; 
       teen => \\c => mkCard c twelve ; 
       ten  => \\c => mkCard c twenty
       }
    } ;

  regNum : Str -> {s : DForm => CardOrd => Str} = 
    \six -> mkNum six (six + "teen") (six + "ty") (regOrd six) ;

  regCardOrd : Str -> {s : CardOrd => Str} = \ten ->
    {s = table {NCard => ten ; NOrd => regOrd ten}} ;

  mkCard : CardOrd -> Str -> Str = \c,ten -> 
    (regCardOrd ten).s ! c ; 

  regOrd : Str -> Str = \ten -> 
    case last ten of {
      "y" => init ten + "ieth" ;
      _   => ten + "th"
      } ;

param Num = Sg | Pl ;
    CardOrd = NCard | NOrd ;
    DForm = unit | teen | ten  ;

}
