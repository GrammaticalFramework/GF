concrete khmer of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=extradiacritics ;

param DForm = unit | ten ;
param Size = sg | pl ;

oper LinDigit = {s : DForm => Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> LinDigit = \u -> \t -> {s = table {unit => u ; ten => t} ; size = pl} ;

lin n2 = mkNum "bīra" "mbhai" ;
lin n3 = mkNum "pī" ("sāma" ++ "sipa") ;
lin n4 = mkNum "pwna" ("sē" ++ "sipa") ;
lin n5 = mkNum "prāṃ" ("hā" ++ "sipa") ;
lin n6 = mkNum ("prāṃ" ++ "mwya") ("huka" ++ "sipa") ;
lin n7 = mkNum ("prāṃ" ++ "bīra") ("cita" ++ "sipa") ;
lin n8 = mkNum ("prāṃ" ++ "pī") ("pēta" ++ "sipa") ;
lin n9 = mkNum ("prāṃ" ++ "pwna") ("kau" ++ "sipa") ;

oper bana : Str = variants {"mwya" ++ "bā'na" ; "mpā'na"} ; 

lin num x = {s = [] ++ x.s ++ []} ; -- for the diacritics

lin pot01 = {s = table { _ => "mwya" } ; size = sg } ;
lin pot0 d = d ; 
lin pot110 = {s = "ṭa'pa" ; s2 = "hmɨna" ; size = pl} ; 
lin pot111 = {s = "mwya" ++ "ṭaṇta'pa" ; s2 = "hmɨna" ++ bana; size = pl} ;
lin pot1to19 d = {s = (d.s ! unit) ++ "ṭaṇta'pa" ; s2 = "hmɨna" ++ (d.s ! unit) ++ "bā'na" ; size = pl } ;
lin pot0as1 n = {s = n.s ! unit ; s2 = xsg n.size bana (n.s ! unit ++ "bā'na") ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; s2 = d.s ! unit ++ "hmɨna" ; size = pl} ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit ; s2 = d.s ! unit ++ "hmɨna" ++ xsg e.size bana (e.s ! unit ++ "bā'na") ; size = pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = xsg d.size (variants {"raya" ; "mraya"}) (d.s ! unit ++ "raya") ; 
              s2 = (d.s ! unit) ++ "sēna" ;
              size = pl } ;
lin pot2plus d e = {s = xsg d.size (variants {"raya" ; "mraya"}) (d.s ! unit ++ "raya") ++ e.s ;
                    s2 = (d.s ! unit) ++ "sēna" ++ e.s2 ; 
                    size = pl} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = n.s2 } ; 
lin pot3plus n m = {s = n.s2 ++ m.s } ;

oper xsg : Size -> Str -> Str -> Str = \sz -> \s1 -> \s2 -> table {sg => s1 ;  _ => s2} ! sz ;




}
