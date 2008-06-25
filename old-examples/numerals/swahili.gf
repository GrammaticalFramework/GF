include numerals.Abs.gf ;

param DForm = unit | ten ; 
param Size = sg | pl | pl_end | more100;
param S1000 = reg | lakh ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size } ;
lincat Sub10 = {s : DForm => Str ; size : Size } ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : S1000 => Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;

oper mkNum : Str -> Str -> Lin Digit = \mbili -> \ishirini -> 
  {s = table {unit => mbili ; ten => ishirini } ; size = pl_end };

-- lin n1 = mkNum "moja" ; 
lin n2 = mkNum "mbili" "ishirini" ;
lin n3 = mkNum "tatu" "thelathini" ;
lin n4 = mkNum "nne" "arobaini" ;
lin n5 = mkNum "tano" "hamsini" ;
lin n6 = mkNum "sita" "sitini" ;
lin n7 = mkNum "saba" "sabini" ;
lin n8 = mkNum "nane" "themanini" ;
lin n9 = mkNum "tisa" "tisini" ;

lin pot01  =
  {s = table {unit => "moja" ; _ => "dummy" } ; size = sg };
lin pot0 d = d ;
lin pot110 = {s = "kumi" ; size = pl_end} ;
lin pot111 = {s = "kumi" ++ "na" ++ "moja" ; size = pl} ;
lin pot1to19 d = {s = "kumi" ++ "na" ++ d.s ! unit ; size = pl} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d = {s = d.s ! ten ; size = pl_end} ;
lin pot1plus d e = {s = d.s ! ten ++ "na" ++ e.s ! unit ; size = pl} ; 
lin pot1as2 n = {s = table {_ => n.s } ; size = n.size} ;
lin pot2 d = {s = table {reg => mkmia d.size (d.s ! unit) ; lakh => mklakh d.size (d.s ! unit) []} ; size = more100};
lin pot2plus d e = 
  {s = table {lakh => mklakh d.size (d.s ! unit) ("elfu" ++ e.s) ; 
              reg => mkmia d.size (d.s ! unit) ++ maybena e.size ++ e.s } ;
   size = more100} ;
lin pot2as3 n = {s = n.s ! reg } ;
lin pot3 n = {s = table {sg => variants {"elfu" ; "elfu" ++ "moja"} ; more100 => n.s ! lakh ; _ => n.s ! reg ++ "elfu"} ! n.size} ; -- invert order in 1 < x < 100 * 1000 if nothing follows the elfu
lin pot3plus n m = {s = table {more100 => n.s ! lakh ; _ => "elfu" ++  n.s ! reg} ! n.size ++ maybena m.size ++ m.s ! reg} ; 

oper lakhi : Str = (variants {"lakh" ; "lakhi" }) ;
oper mia : Str = (variants { "mia" ; "mia" ++ "moja" }) ;
oper maybena : Size -> Str = \sz -> table {sg => "na" ; pl_end => "na" ; _ => []} ! sz ;
oper mklakh : Size -> Str -> Str -> Str = \sz -> \attr -> \elfu -> 
  table {sg => lakhi ; _ => lakhi ++ attr} ! sz ++ elfu ;
oper mkmia : Size -> Str -> Str = \sz -> \attr ->
  table {sg => mia; _ => "mia" ++ attr } ! sz ;
