include numerals.Abs.gf ;

param DForm = unit | ten ;
param Size = sg | pl ;

oper LinDigit = {s : DForm => Str ; size : Size} ;

lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size} ;

oper mkNum : Str -> Str -> LinDigit = \u -> \t -> {s = table {unit => u ; ten => t} ; size = pl} ;

lin n2 = mkNum "bi:ra" "mbhai" ;
lin n3 = mkNum "pi:" ("sa:ma" ++ "sipa") ;
lin n4 = mkNum "pwna" ("se:" ++ "sipa") ;
lin n5 = mkNum "pra:m." ("ha:" ++ "sipa") ;
lin n6 = mkNum ("pra:m." ++ "mwya") ("huka" ++ "sipa") ;
lin n7 = mkNum ("pra:m." ++ "bi:ra") ("cita" ++ "sipa") ;
lin n8 = mkNum ("pra:m." ++ "pi:") ("pe:ta" ++ "sipa") ;
lin n9 = mkNum ("pra:m." ++ "pwna") ("kau" ++ "sipa") ;

oper bana : Str = variants {"mwya" ++ "ba:'na" ; "mpa:'na"} ; 

lin num x = {s = "/X" ++ x.s ++ "X/"} ; -- for the diacritics

lin pot01 = {s = table { _ => "mwya" } ; size = sg } ;
lin pot0 d = d ; 
lin pot110 = {s = "t.a'pa" ; s2 = "hmi-na" ; size = pl} ; 
lin pot111 = {s = "mwya" ++ "t.an.ta'pa" ; s2 = "hmi-na" ++ bana; size = pl} ;
lin pot1to19 d = {s = (d.s ! unit) ++ "t.an.ta'pa" ; s2 = "hmi-na" ++ (d.s ! unit) ++ "ba:'na" ; size = pl } ;
lin pot0as1 n = {s = n.s ! unit ; s2 = xsg n.size bana (n.s ! unit ++ "ba:'na") ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; s2 = d.s ! unit ++ "hmi-na" ; size = pl} ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit ; s2 = d.s ! unit ++ "hmi-na" ++ xsg e.size bana (e.s ! unit ++ "ba:'na") ; size = pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = xsg d.size (variants {"raya" ; "mraya"}) (d.s ! unit ++ "raya") ; 
              s2 = (d.s ! unit) ++ "se:na" ;
              size = pl } ;
lin pot2plus d e = {s = xsg d.size (variants {"raya" ; "mraya"}) (d.s ! unit ++ "raya") ++ e.s ;
                    s2 = (d.s ! unit) ++ "se:na" ++ e.s2 ; 
                    size = pl} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = n.s2 } ; 
lin pot3plus n m = {s = n.s2 ++ m.s } ;

oper xsg : Size -> Str -> Str -> Str = \sz -> \s1 -> \s2 -> table {sg => s1 ;  _ => s2} ! sz ;



