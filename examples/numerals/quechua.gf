concrete quechua of Numerals = {
-- include numerals.Abs.gf ;

param DForm = unit | havingunit ;
param Size = sg | pl ; 

-- Quechua har no standard orthography so there are numerous spelling variants
-- not considered here.

lincat Numeral =    { s : Str } ;
oper LinDigit = {s : DForm => Str ; size : Size} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkRegNum1 : Str -> LinDigit = 
  \juk -> 
  { s = table { unit => juk ; havingunit => juk + "niyuq" } ; size = pl}; 

oper mkRegNum2 : Str -> LinDigit = 
  \kinsa -> 
  { s = table { unit => kinsa ; havingunit => kinsa + "yuq" } ; size = pl};

lin num x = x ;
-- lin n1 mkRegNum1 "juk";
lin n2 = mkRegNum1 "iskay";
lin n3 = mkRegNum2 "kinsa";
lin n4 = mkRegNum2 "tawa";
lin n5 = mkRegNum2 "pishq'a" ;
lin n6 = mkRegNum2 "suqta";
lin n7 = mkRegNum1 "k'anchis" ;
lin n8 = mkRegNum1 "pusaq" ;
lin n9 = mkRegNum1 "isk'un" ;

lin pot01 = {s = table { unit => "juk" ; havingunit => "juk" + "niyuq" } ; size = sg} ;
lin pot0 d = d ;
lin pot110 = {s = "chunka" ; size = pl } ;
lin pot111 = {s = "chunka" ++ "jukniyuq" ; size = pl } ;
lin pot1to19 d = {s = "chunka" ++ d.s ! havingunit ; size = pl } ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! unit ++ "chunka" ; size = pl} ;
lin pot1plus d e = {s = (d.s ! unit ++ "chunka") ++ e.s ! havingunit ; size = pl } ;
lin pot1as2 n = n ;
lin pot2 d = {s = (drop (d.s ! unit)) ! d.size ++ "pachak" ; size = pl} ;
lin pot2plus d e = {s = (drop (d.s ! unit)) ! d.size ++ "pachak" ++ e.s ; size = pl} ;

lin pot2as3 n = n ;
lin pot3 n = {s = (drop n.s) ! n.size ++ "warank'a"} ;
lin pot3plus n m = {s = (drop n.s) ! n.size ++ "warank'a" ++ m.s} ;

oper drop : Str -> Size => Str = \s -> table {sg => [] ; pl => s } ; 

}
