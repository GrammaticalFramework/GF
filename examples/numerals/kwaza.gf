include numerals.Abs.gf ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : Str } ;
lincat Sub10 = {s : Str } ;
lincat Sub100 = {s : Str } ;
lincat Sub1000 = {s : Str } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO

oper na = {s = "N/A" } ;

lin n2 = {s = "aky'hy~" };
lin n3 = {s = "e'ma~" };
lin n4 = {s = "ElE'lE" };
lin n5 = {s = "bwako'je" };
lin n6 = na ;
lin n7 = na ;
lin n8 = na ;
lin n9 = na ;

lin pot01 =
  {s = "tei'hy~"};
lin pot0 d = d ;
lin pot110 = na ;
lin pot111 = na ;
lin pot1to19 d = na ;
lin pot0as1 n = n ;
lin pot1 d = na ;
lin pot1plus d e = na ;
lin pot1as2 n = n ;
lin pot2 d = na ;
lin pot2plus d e = na ;
lin pot2as3 n = n ;
lin pot3 n = na ;
lin pot3plus n m = na ;
