-- ä is ya
-- q is [ch]
-- w for [sh]
-- j for i kratkoe i.e i with a thing

include numerals.Abs.gf ;
flags coding=russian ;

param Size = sg | below10 | tenover ; 
param DForm = unit | teen | ten | hundred ;

oper LinDigit = {s : DForm => Str ; size : Size } ;

lincat Digit = LinDigit ;     
lincat Sub10 = LinDigit ;
lincat Sub100 =     {s : Str ; size : Size } ;
lincat Sub1000 =    {s : Str ; size : Size } ;

oper mkNum : Str -> Str -> Str -> LinDigit = \tri -> \trijset -> \trista -> 
  { s = table {unit => tri ; teen => variants {tri + "nadeset" ; tri + "najset" }; ten => trijset ; hund => trista} ; size = below10};

lin num x = {s = "/_" ++ x.s ++ "_/"} ; -- the (Russian) Cyrillic ad-hoc translation 

lin n2 = {s = table {unit => "dve" ; teen => variants {"dvanadeset" ; "dvanajset"}; ten => "dvajset" ; hund => "dvesta" } ; size = below10 } ;
lin n3 = mkNum "tri" (variants {"trijset"; "trideset"}) "trista" ;
lin n4 = mkNum "qetiri" (variants {"qetiriset" ; "qetirijset" ; "qetirideset"}) "qetiristotin" ;
lin n5 = mkNum "pet" "petdeset" "petstotin" ;
lin n6 = mkNum "west" (variants {"westdeset" ; "wejset"}) "weststotin" ;
lin n7 = mkNum "sedem" "sedemdeset" "sedemstotin" ;
lin n8 = mkNum "osem" "osemdeset" "osemstotin" ;
lin n9 = mkNum "devet" "devetdeset" "devetstotin" ;

lin pot01 = { s = table {unit => "edno" ; hundred => "sot" ; _ => "dummy" } ; size = sg };
lin pot0 d = d ;
lin pot110 = {s = "deset" ; size = below10};
lin pot111 = {s = variants {"edinadeset" ; "edinajset" }; size = tenover};
lin pot1to19 d = {s = d.s ! teen ; size = tenover};
lin pot0as1 n = {s = n.s ! unit ; size = n.size } ;
lin pot1 d = {s = d.s ! ten ; size = tenover} ;
lin pot1plus d e = {s = d.s ! ten ++ "i" ++ e.s ! unit ; size = tenover} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! hundred ; size = tenover} ;
lin pot2plus d e = { s = d.s ! hundred ++ maybei e.size ++ e.s ; size = tenover } ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = mkThou n.size n.s} ;
lin pot3plus n m = {s = mkThou n.size n.s ++ m.s} ;

oper mkThou : Size -> Str -> Str = \sz -> \attr ->
  table {sg => "xiläda" ; _ => attr ++ "xilädi" } ! sz ;

oper maybei : Size -> Str = \sz -> table {tenover => [] ; _ => "i"} ! sz ; 

