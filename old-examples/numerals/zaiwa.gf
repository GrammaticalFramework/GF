include numerals.Abs.gf ;

flags lexer = words ;

param Size = sg | sub10 | pl ;

oper LinDigit = {s : Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> LinDigit = \u -> {s = u ; size = sub10} ;

lin n2 = mkNum "i55" ;
lin n3 = mkNum "sum11" ;
lin n4 = mkNum "mi11" ;
lin n5 = mkNum "ngo11" ;
lin n6 = mkNum "kyuq5" ;
lin n7 = mkNum "ngit5" ;
lin n8 = mkNum "sit5" ;
lin n9 = mkNum "gau11" ;

oper ten : Str = variants {"cue31" ; "sue31"};
oper mun : Str = variants {"mun11" ; ("mun11" + "mo35")} ;
oper xmun : Size => Str = table {pl => [] ; _ => mun} ;

lin num x = {s = x.s} ; -- TODO

lin pot01 = {s = "ra11" ; size = sg } ;
lin pot0 d = d ; 
lin pot110 = {s = "le1" ++ ten ;
              s2 = "le1" ++ mun ; size = pl} ; 
lin pot111 = {s = ("le1" ++ ten) ++ "ra11"; 
              s2 = ("le1" ++ mun) ++ ("le1" ++ "hing55"); size = pl} ;
lin pot1to19 d = {s = ("le1" ++ ten) ++ d.s ; 
                  s2 = ("le1" ++ mun) ++ d.s ++ "hing55"; size = pl};
lin pot0as1 n = {s = n.s ; s2 = ifsg n.s ! n.size ++ "hing55" ; size = n.size};
lin pot1 d = {s = d.s ++ ten ; s2 = d.s ++ mun ; size = pl} ;
lin pot1plus d e = {s = d.s ++ ten ++ e.s ; s2 = d.s ++ mun ++ ifsg e.s ! e.size ++ "hing55" ; size = pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = ifsg d.s ! d.size ++ "syo31" ; 
              s2 = ifsg d.s ! d.size ++ ten ++ mun ;
              size = pl } ;
lin pot2plus d e = {s = ifsg d.s ! d.size ++ "syo31" ++ e.s; 
                    s2 = ifsg d.s ! d.size ++ ten ++ xmun ! e.size ++ e.s2 ; 
                    size = pl} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = n.s2 } ; 
lin pot3plus n m = {s = n.s2 ++ m.s } ;

oper ifsg : Str -> Size => Str = \attr -> table {sg => "le1" ;  _ => attr} ;



