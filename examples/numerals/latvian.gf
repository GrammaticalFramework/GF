-- c^
-- s^ 
-- n, is n with a comma under
-- u^ with line over

include numerals.Abs.gf ;

param DForm = unit | teen | ten | hundred ; 

oper LinDigit = {s : DForm => Str ; s2 : Str };
oper LinSub100 = {s : Str ; s2 : Str } ;

lincat Digit =      LinDigit ;
lincat Sub10 =      LinDigit ;
lincat Sub100 =     LinSub100 ;
lincat Sub1000 =    LinSub100 ;

oper mkNum : Str -> Str -> LinDigit = \tri -> \tribase -> 
  { s = table {unit => tri ; teen => tribase + "padsmit" ; ten => tribase + "desmit" ; hundred => variants {tribase + "simt" ; tri ++ "simti"} } ; s2 = tribase + "tu^kstos^" };

lin num x = {s = "/L" ++ x.s ++ "L/"} ; -- Latin A Supplement diacritics ;

lin n2 = mkNum "divi" "div" ;
lin n3 = mkNum "tri:s" "tri:s" ;
lin n4 = mkNum "c^etri" "c^etr" ; 
lin n5 = mkNum "pieci" "piec" ;
lin n6 = mkNum "ses^i" "ses^" ;
lin n7 = mkNum "septin,i" "septin," ;
lin n8 = mkNum "aston,i" "aston," ;
lin n9 = mkNum "devin,i" "devin," ;

oper mkR : Str -> LinSub100 = \n -> {s = n ; s2 = n ++ "tu^kstos^" } ;  

lin pot01 = { s = table {hundred => "simts" ;  _ => "viens" } ; s2 = "tu^kstotis" };
lin pot0 d = d ;
lin pot110 = mkR "desmit" ;
lin pot111 = mkR "vienpadsmit" ;
lin pot1to19 d = mkR (d.s ! teen) ;
lin pot0as1 n = {s = n.s ! unit ; s2 = n.s2 } ;
lin pot1 d = mkR (d.s ! ten) ;
lin pot1plus d e = mkR ((d.s ! ten) ++ (e.s ! unit)) ;
lin pot1as2 n = n ;
lin pot2 d = mkR (d.s ! hundred) ;
lin pot2plus d e = mkR ((d.s ! hundred) ++ e.s) ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = n.s2} ;
lin pot3plus n m = {s = n.s2 ++ m.s} ;


