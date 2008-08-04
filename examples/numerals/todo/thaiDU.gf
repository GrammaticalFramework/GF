concrete thaiDU of Numerals = {
-- include numerals.Abs.gf ;

-- Thai digits. AR 28/12/2006

flags lexer=chars ; unlexer=concat ; flags coding=utf8 ;

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
lin n2 = ss "๒" ;
lin n3 = ss "๓" ;
lin n4 = ss "๔" ;
lin n5 = ss "๕" ;
lin n6 = ss "๖" ;
lin n7 = ss "๗" ;
lin n8 = ss "๘" ;
lin n9 = ss "๙" ;

lin pot01 = ss "๑" ;
lin pot0 d = d ;

lin pot110 = mkz ("๑" ++ "๐") ;
lin pot111 = mkz ("๑" ++ "๑") ;
lin pot1to19 d = mkz ("๑" ++ d.s) ;

lin pot0as1 n = {s = table {noz => n.s ; zz => "๐" ++ n.s}} ;

lin pot1 d = mkz (d.s ++ "๐") ;
lin pot1plus d e = mkz (d.s ++ e.s) ;

lin pot1as2 n = {s = table {noz => n.s ! noz ; zz => "๐" ++ n.s ! zz}} ;
lin pot2 d = mkz (d.s ++ "๐" ++ "๐") ;
lin pot2plus d e = mkz (d.s ++ e.s ! zz) ;

lin pot2as3 n = {s = table {noz => n.s ! noz ; zz => "๐" ++ n.s ! zz}} ;

lin pot3 n = mkz (n.s ! noz ++ "๐" ++ "๐" ++ "๐") ;
lin pot3plus n m = {s = table {z => n.s ! z ++ m.s ! zz}} ;

}
