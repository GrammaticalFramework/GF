include numerals.Abs.gf ;

flags lexer=chars ; unlexer=concat ;

param Zeros = noz  | zz  ;

lincat Numeral =    { s : Str } ;
lincat Digit =      { s : Str } ;
lincat Sub10 =      { s : Str } ;
lincat Sub100 = {s : Zeros => Str} ;
lincat Sub1000 = {s : Zeros => Str} ;
lincat Sub1000000 = {s : Zeros => Str} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;
oper mkz : Str -> {s : Zeros => Str} = \s -> {s = table {_ => s}} ;

lin num n = {s = n.s ! noz} ;
lin n2 = ss "2" ;
lin n3 = ss "3" ;
lin n4 = ss "4" ;
lin n5 = ss "5" ;
lin n6 = ss "6" ;
lin n7 = ss "7" ;
lin n8 = ss "8" ;
lin n9 = ss "9" ;

lin pot01 = ss "1" ;
lin pot0 d = d ;

lin pot110 = mkz ("1" ++ "0") ;
lin pot111 = mkz ("1" ++ "1") ;
lin pot1to19 d = mkz ("1" ++ d.s) ;

lin pot0as1 n = {s = table {noz => n.s ; zz => "0" ++ n.s}} ;

lin pot1 d = mkz (d.s ++ "0") ;
lin pot1plus d e = mkz (d.s ++ e.s) ;

lin pot1as2 n = {s = table {noz => n.s ! noz ; zz => "0" ++ n.s ! zz}} ;
lin pot2 d = mkz (d.s ++ "0" ++ "0") ;
lin pot2plus d e = mkz (d.s ++ e.s ! zz) ;

lin pot2as3 n = {s = table {noz => n.s ! noz ; zz => "0" ++ n.s ! zz}} ;

lin pot3 n = mkz (n.s ! noz ++ "0" ++ "0" ++ "0") ;
lin pot3plus n m = {s = table {z => n.s ! z ++ m.s ! zz}} ;
