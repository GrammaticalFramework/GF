include numerals.Abs.gf ;

param Size = sg | pl ;
param DForm = unit | teen | ten | ten2 ;

oper LinDigit = {s : DForm => Str ; size : Size } ;
oper Form = {s : Str ; size : Size } ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = Form ;
lincat Sub1000 = Form ;
lincat Sub1000000 = {s : Str} ;
lin num x0 = {s = x0.s} ; 

oper mkNum : Str -> LinDigit = \u ->
  {s = table {unit => u ; teen => "kudha" + u; ten => u + "tama" ; ten2 => u + "tamii"}; size = pl };

oper mkNum2 : Str -> Str -> LinDigit = \u -> \t ->
  {s = table {unit => u ; teen => "kudha" + u; ten => t + "a" ; ten2 => t + "ii"}; size = pl };

-- lin n1 = mkNum "tokko" ; 
lin n2 = mkNum2 "lama" "digdam";
lin n3 = {s = table {unit => "sadii" ; teen => "kudhasadii" ; ten => "soddoma" ; ten2 => "soddomii"} ; size = pl};
lin n4 = {s = table {unit => "afur" ; teen => variants {"kudha'afur" ; "kudhafur"} ; ten => "afur" + "tama" ; ten2 => "afur" + "tamii"} ; size = pl} ;
lin n5 = mkNum "shan" ;
lin n6 = mkNum2 (variants {"ja'a" ; "jaha"}) "jaatam" ;
lin n7 = mkNum2 "torba" "torbaatam";
lin n8 = mkNum "saddeet" ;
lin n9 = mkNum "sagal" ;

oper ss : Str -> Form = \s1 -> {s = s1 ; size = pl} ;

lin pot01  =
  {s = table {f => "tokko" }; size = sg };
lin pot0 d = d ;
lin pot110 = ss "kudhan" ; 
lin pot111 = ss "kudhatokko" ; 
lin pot1to19 d = ss (d.s ! teen) ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size } ;
lin pot1 d = ss (d.s ! ten) ;
lin pot1plus d e = ss (d.s ! ten2 ++ e.s ! unit) ; 
lin pot1as2 n = n ;
lin pot2 d = ss (selsg (d.s ! unit) "dhibba" ! d.size);
lin pot2plus d e = ss (selsg (d.s ! unit) "dhibba" ! d.size ++ "fi" ++ e.s) ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = (selsg n.s "kuma") ! n.size} ;
lin pot3plus n m = {s = (selsg n.s "kuma") ! n.size ++ "fi" ++ m.s} ;

oper selsg : Str -> Str -> Size => Str = \attr -> \i ->  
  table {pl => i ++ attr ; sg => variants {i ; i ++ attr }} ; 
