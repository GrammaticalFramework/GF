concrete old_church_slavonic of Numerals = {
flags coding = utf8 ;
-- je, jo, ja for je, jo, ja etc
-- U, I yers
-- ä is jat' 
-- q is [ch]
-- y for [bi]
-- e~, o~
-- w for [sh]

-- include numerals.Abs.gf ;
-- flags coding=OCScyrillic ;

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

lin num x = {s = [] ++ x.s ++ []} ; -- the Old Church Slavonic Cyrillic script ;

lin n2 = {s = "дъва" ; s2 = [] ; size = dual };
lin n3 = mkNum (variants {"триѥ" ; "трьѥ" }) threefour ;
lin n4 = mkNum "четыре" threefour ;
lin n5 = mkNum5 "пѧть" ;
lin n6 = mkNum5 "шесть" ;
lin n7 = mkNum5 "седмь" ;
lin n8 = mkNum5 "осмь" ;
lin n9 = mkNum5 "девѧть" ;

lin pot01 = { s = "ѥдинъ" ; s2 = [] ; size = sg };
lin pot0 d = d ;
lin pot110 = mkNum5 "десѧть" ;
lin pot111 = mkNum5 ("ѥдинъ" ++ "на" ++ "десѧте") ;
lin pot1to19 d = mkNum5 (d.s ++ "на" ++ "десѧте") ;
lin pot0as1 n = n ;
lin pot1 d = {s = mkTen d.size d.s ; s2 = mkTen d.size d.s ; size = fiveup} ;
lin pot1plus d e = {s = mkTen d.size d.s ++ variants {"и" ; "ти"} ++ e.s ; s2 =mkTen d.size d.s ++ variants {"и" ; "ти"} ++ mkattr e.size e.s ; size = e.size} ;
lin pot1as2 n = n ;
lin pot2 d = {s = mkHund d.size d.s ; s2 = mkHund d.size d.s ; size = fiveup} ;
lin pot2plus d e = { s = mkHund d.size d.s ++ e.s ; s2 = mkHund d.size d.s ++ e.s2 ; size = e.size } ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = n.s2 ++ mkThou n.size} ;
lin pot3plus n m = {s = n.s2 ++ mkThou n.size ++ m.s} ;

oper mkThou : Size -> Str = \sz -> 
  table {sg => (variants {"тысѭшти" ; "тысѩшти"}) ; dual => ("дъвѣ" ++ "тысѭшти") ; threefour => "тысѭштѧ" ; fiveup => "тысѭшть" } ! sz ;

oper mkHund : Size -> Str -> Str = \sz -> \s -> 
  table {sg => "съто" ; dual => "дъвѣ" ++ "сътѣ" ; threefour => s ++ "съта" ; fiveup => s ++ "сътъ" } ! sz ;

oper mkTen : Size -> Str -> Str = \sz -> \s -> 
  table {sg => "десѧть" ; dual => s ++ "десѧти" ; threefour => s ++ "десѧте" ; fiveup => s ++ "десѧтъ" } ! sz ; 

oper mkattr : Size -> Str -> Str = \sz -> \s -> table {dual => [] ; _ => s} ! sz;

}
