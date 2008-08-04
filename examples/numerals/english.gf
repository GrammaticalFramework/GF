concrete english of Numerals = {
-- include numerals.Abs.gf ;

param DForm = unit  | teen  | ten  ;

lincat Numeral =    { s : Str } ;
oper LinDigit = {s : DForm => Str} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str} ;
lincat Sub100 =     { s : Str } ;
lincat Sub1000 =    { s : Str } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> LinDigit = 
  \two -> \twelve -> \twenty -> 
  {s = table {unit => two ; teen => twelve ; ten => twenty}} ;
oper regNum : Str -> LinDigit = 
  \six -> mkNum six (six + "teen") (six + "ty") ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin num x = x ;
lin n2 = mkNum "two"   "twelve"   "twenty" ;
lin n3 = mkNum "three" "thirteen" "thirty" ;
lin n4 = mkNum "four"  "fourteen" "forty" ;
lin n5 = mkNum "five"  "fifteen"  "fifty" ;
lin n6 = regNum "six" ;
lin n7 = regNum "seven" ;
lin n8 = mkNum "eight" "eighteen" "eighty" ;
lin n9 = regNum "nine" ;

lin pot01 = {s = table {f => "one"}} ;
lin pot0 d = {s = table {f => d.s ! f}} ;
lin pot110 = ss "ten" ;
lin pot111 = ss "eleven" ;
lin pot1to19 d = {s = d.s ! teen} ;
lin pot0as1 n = {s = n.s ! unit} ;
lin pot1 d = {s = d.s ! ten} ;
lin pot1plus d e = {s = d.s ! ten ++ "-" ++ e.s ! unit} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! unit ++ "hundred"} ;
lin pot2plus d e = {s = d.s ! unit ++ "hundred" ++ "and" ++ e.s} ;
lin pot2as3 n = n ;
lin pot3 n = {s = n.s ++ "thousand"} ;
lin pot3plus n m = {s = n.s ++ "thousand" ++ m.s} ;


}
