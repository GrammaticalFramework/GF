concrete stieng of Numerals = {
-- include numerals.Abs.gf ;

param Size = sg | belowten | moreten ;

oper LinDigit = {s : Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> LinDigit = \u -> {s = u ; size = belowten} ;

lin n2 = mkNum "baar" ;
lin n3 = mkNum "pê" ;
lin n4 = mkNum "puôn" ;
lin n5 = mkNum "pram" ;
lin n6 = mkNum "prau" ;
lin n7 = mkNum "poh" ;
lin n8 = mkNum "phaam" ;
lin n9 = mkNum "sên" ;

oper ban : Str = (variants {"ban" ; "rabu"} ) ;

lin num x = x ;

lin pot01 = {s = variants {"muôi" ; "du" ; "di"} ; size = sg } ;
lin pot0 d = d ; 
lin pot110 = {s = "jo'mo't" ; s2 = variants {"mu'n" ; "jo'm'ot" ++ "ban"} ; size = moreten} ; 
lin pot111 = {s = "jo'mo't" ++ "muôi" ; s2 = variants {"mu'n" ++ ban ; "jo'm'ot" ++ "muôi" ++ ban} ; size = moreten} ;
lin pot1to19 d = {s = "jo'mo't" ++ d.s ; s2 = variants {"mu'n" ++ d.s ++ "ban"; "jo'm'ot" ++ d.s ++ "ban"} ; size = moreten };
lin pot0as1 n = {s = n.s ; s2 = xsg n.size ban (n.s ++ "ban") ; size = n.size} ;
lin pot1 d = {s = d.s ++ "jo't" ; s2 = variants {d.s ++ "mu'n" ; d.s ++ "jo't" ++ "ban"} ; size = moreten} ;
lin pot1plus d e = {s = d.s ++ "jo't" ++ e.s ; s2 = variants {d.s ++ "mu'n" ; d.s ++ "jo't" } ++ xsg e.size ban (e.s ++ "ban") ; size = moreten} ;
lin pot1as2 n = n ;
lin pot2 d = {s = xsg d.size (variants { "riêng" ; "rhiêng" }) (d.s ++ "riêng") ; 
              s2 = xsg d.size "seen" (d.s ++ "seen") ;
              size = moreten} ;
lin pot2plus d e = {s = xsg d.size (variants { "riêng" ; "rhiêng" }) (d.s ++ "riêng") ++ maybeo e.size ++ e.s ;
                    s2 = xsg d.size "seen" (d.s ++ "seen") ++ e.s2 ; 
                    size = moreten} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = table {sg => (variants {"ban" ; "rabu"}) ; 
                         belowten => n.s ++ "ban" ; 
                         tenover => n.s2} ! n.size } ; 
lin pot3plus n m = {s = table {sg => (variants {"ban" ; "rabu"}) ; 
                               belowten => n.s ++ "ban" ; 
                               tenover => n.s2} ! n.size ++ maybeo m.size ++ m.s } ;

oper maybeo : Size -> Str = \sz -> table {moreten => [] ; _ => "ô"} ! sz;
oper xsg : Size -> Str -> Str -> Str = \sz -> \s1 -> \s2 -> table {sg => s1 ;  _ => s2} ! sz ;




}
