include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ;
oper na : {s : Str } = {s = "N/A" } ; 

oper LinDigit = {s : Str ; s2 : Str ; s3 : Str} ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str } ;
lincat Sub1000 = {s : Str } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO

oper mkNum : Str -> LinDigit = \s1 -> {s = s1 ; s2 = s1 + "yu" ; s3 = s1 + "suu"} ;
oper mkNum2 : Str -> LinDigit = \s1 -> {s = s1 ; s2 = s1 + "yu" ; s3 = s1 + "cuu"} ;
lin n2 = mkNum "waha" ;
lin n3 = mkNum "pehe" ;
lin n4 = mkNum "wacuu" ;
lin n5 = mkNum2 "mani-gi" ;
lin n6 = mkNum2 "navaha" ;
lin n7 = {s = "no?mi-zi" ; s2 = "no?mi-zi" ; s3 = "no?mi-zicuu" };
lin n8 = {s = "nanawacuu" ; s2 = "nanawacuu"; s3 = "nanawacuucuu" };
lin n9 = mkNum2 "sukumi-su" ;

lin pot01 = mkNum "suu" ;
lin pot0 d = d ;
lin pot110 = {s = "mi-mi-suuyu" } ;
lin pot111 = {s = "mi-mi-susuuyu" } ;
lin pot1to19 d = {s = bind "mi-mi-susuu" d.s2 } ;
lin pot0as1 n = {s = n.s } ;
lin pot1 d = {s = bind d.s3 "yu"} ;
lin pot1plus d e = {s = bind d.s3 e.s2 } ;
lin pot1as2 n = n ;
lin pot2 d = na ;
lin pot2plus d e = na ;
lin pot2as3 n = n ;
lin pot3 n = na ;
lin pot3plus n m = na ;
