concrete interlingua of Numerals = {
-- include numerals.Abs.gf ;

param DForm = unit | ten  ;

lincat Numeral	  = { s : Str } ;
oper LinDigit	  = { s : DForm => Str } ;
lincat Digit = LinDigit ;

lincat Sub10	  = { s : DForm => Str } ;
lincat Sub100	  = { s : Str } ;
lincat Sub1000	  = { s : Str } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> LinDigit = 
  \duo-> \vinti-> 
  {s = table {unit => duo ; ten => vinti}} ;

oper regNum : Str -> LinDigit = 
  \cinque -> 
       case cinque of {
	 nov   + "em"=> mkNum cinque (nov   + "anta");
	 cinqu + "e" => mkNum cinque (cinqu + "anta");
	 cinqu + "o" => mkNum cinque (cinqu + "anta");
	 sex         => mkNum sex    (sex   + "anta")
       };

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin num x = x ;
lin n2 = mkNum  "duo"    "vinti";
lin n3 = mkNum  "tres"   "trenta";
lin n4 = mkNum  "quatro" "quaranta";
lin n5 = regNum "cinque";
lin n6 = regNum "sex"   ;
lin n7 = regNum "septe" ;
lin n8 = regNum "octo"  ;
lin n9 = regNum "novem"  ;

lin pot01 = {s = table {f => "un"}} ;
lin pot0 d = {s = table {f => d.s ! f}} ;
lin pot110 = ss "dece" ;
lin pot111 = ss ("dece" ++ "-" ++ "un");
lin pot1to19 d = {s = "dece" ++ "-" ++ d.s ! unit} ;
lin pot0as1 n = {s = n.s ! unit} ;

lin pot1 d       = {s = d.s ! ten} ;
lin pot1plus d e = {s = d.s ! ten ++ "-" ++ e.s ! unit} ;

lin pot1as2 n = n ;

lin pot2     d   = {s = d.s ! unit ++ "cento"} ;
lin pot2plus d e = {s = d.s ! unit ++ "cento" ++ e.s} ;

lin pot2as3 n = n ;

lin pot3     n   = {s = n.s ++ "mille"} ;
lin pot3plus n m = {s = n.s ++ "mille" ++ m.s} ;


}
