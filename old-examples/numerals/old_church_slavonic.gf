-- je, jo, ja for je, jo, ja etc
-- U, I yers
-- ä is jat' 
-- q is [ch]
-- y for [bi]
-- e~, o~
-- w for [sh]

include numerals.Abs.gf ;
flags coding=OCScyrillic ;

param Size = sg | dual | threefour | fiveup ; 

lincat Numeral =    { s : Str } ;
lincat Digit =      {s : Str ; s2 : Str ; size : Size } ;
lincat Sub10 =      {s : Str ; s2 : Str ; size : Size } ;
lincat Sub100 =     {s : Str ; s2 : Str ; size : Size } ;
lincat Sub1000 =    {s : Str ; s2 : Str ; size : Size } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Size -> {s : Str ; s2 : Str ; size : Size} = 
  \petI -> \sz -> { s = petI ; s2 = petI ; size = sz};

oper mkNum5 : Str -> {s : Str ; s2 : Str ; size : Size} = \s -> mkNum s fiveup ;

lin num x = {s = "/C" ++ x.s ++ "C/"} ; -- the Old Church Slavonic Cyrillic script ;

lin n2 = {s = "dUva" ; s2 = [] ; size = dual };
lin n3 = mkNum (variants {"trije" ; "trIje" }) threefour ;
lin n4 = mkNum "qetyre" threefour ;
lin n5 = mkNum5 "pe~tI" ;
lin n6 = mkNum5 "westI" ;
lin n7 = mkNum5 "sedmI" ;
lin n8 = mkNum5 "osmI" ;
lin n9 = mkNum5 "deve~tI" ;

lin pot01 = { s = "jedinU" ; s2 = [] ; size = sg };
lin pot0 d = d ;
lin pot110 = mkNum5 "dese~tI" ;
lin pot111 = mkNum5 ("jedinU" ++ "na" ++ "dese~te") ;
lin pot1to19 d = mkNum5 (d.s ++ "na" ++ "dese~te") ;
lin pot0as1 n = n ;
lin pot1 d = {s = mkTen d.size d.s ; s2 = mkTen d.size d.s ; size = fiveup} ;
lin pot1plus d e = {s = mkTen d.size d.s ++ variants {"i" ; "ti"} ++ e.s ; s2 =mkTen d.size d.s ++ variants {"i" ; "ti"} ++ mkattr e.size e.s ; size = e.size} ;
lin pot1as2 n = n ;
lin pot2 d = {s = mkHund d.size d.s ; s2 = mkHund d.size d.s ; size = fiveup} ;
lin pot2plus d e = { s = mkHund d.size d.s ++ e.s ; s2 = mkHund d.size d.s ++ e.s2 ; size = e.size } ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = n.s2 ++ mkThou n.size} ;
lin pot3plus n m = {s = n.s2 ++ mkThou n.size ++ m.s} ;

oper mkThou : Size -> Str = \sz -> 
  table {sg => (variants {"tysjo~wti" ; "tysje~wti"}) ; dual => ("dUvä" ++ "tysjo~wti") ; threefour => "tysjo~wte~" ; fiveup => "tysjo~wtI" } ! sz ;

oper mkHund : Size -> Str -> Str = \sz -> \s -> 
  table {sg => "sUto" ; dual => "dUvä" ++ "sUtä" ; threefour => s ++ "sUta" ; fiveup => s ++ "sUtU" } ! sz ;

oper mkTen : Size -> Str -> Str = \sz -> \s -> 
  table {sg => "dese~tI" ; dual => s ++ "dese~ti" ; threefour => s ++ "dese~te" ; fiveup => s ++ "dese~tU" } ! sz ; 

oper mkattr : Size -> Str -> Str = \sz -> \s -> table {dual => [] ; _ => s} ! sz;
