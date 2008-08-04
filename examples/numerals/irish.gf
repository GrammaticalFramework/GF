concrete irish of Numerals = {
-- include numerals.Abs.gf ;

-- Not the archaic base-10 system fiche, triocha, daichead, caoga, seasca, seachtó, ochtó, nócha
-- scór can be used in place of fiche but is not implemented (since it's much less preferred)

oper LinDigit = {s : DForm => Str ; even20 : Even20 ; size : Size} ;
oper mk20Ten : Str -> Str -> Size -> LinDigit = 
  \tri -> \fiche -> \thesize -> 
  { s = table {unit => tri ; twenty => fiche ; teen => tri ++ "déag" ; attrib => tri} ; even20 = ten ; size = thesize} ;

oper mkEven20 : Str -> Str -> Size -> LinDigit = 
  \se -> \trifichid -> \thesize -> 
  { s = table {unit => se ; twenty => trifichid ; teen => se ++ "déag" ; attrib => se} ; even20 = even ; size = thesize} ;

param HForm = attr | indep ;
param Even20 = ten | even ;
param DForm = unit | twenty | teen | attrib ;
param Size = sg | onetosix | seventonine | tenover | eventen ;
 
lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : HForm  => Str ; size : Size} ;
lincat Sub1000 = {s : HForm => Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  =
  {s = table {unit => "dó" ; twenty => "fiche" ; attrib => "dhá" ; teen => "dó" ++ "dhéag" } ; even20 = even ; size = onetosix } ; 
lin n3  = mk20Ten "trí" "fiche" onetosix ;
lin n4  =
  {s = table {unit => "ceathair" ; twenty => "dhá" ++ "fhichead" ; teen => "dó" ++ "dhéag" ; attrib => "ceithre" } ; even20 = even ; size = onetosix} ;
lin n5  = mk20Ten "cúig" ("dhá" ++ "fhichead") onetosix ;
lin n6  = mkEven20 "sé" ("trí" ++ "fichid") onetosix ;
lin n7  = mk20Ten "seacht" ("trí" ++ "fichid") seventonine ;
lin n8  = mkEven20 "hocht" ("cheithre" ++ "fichid") seventonine ;
lin n9  = mk20Ten "naoi" ("cheithre" ++ "fichid") seventonine ;

lin pot01  =
  {s = table {unit => "haon" ; attrib => [] ; _ => "dummy"} ; even20 = ten ; size = sg};
lin pot0 d =
  {s = d.s ; even20 = d.even20 ; size = d.size} ;
lin pot110 =
  {s = table {attr => "deich" ; indep => "a" ++ "deich"} ; size = tenover} ;
lin pot111  =
  {s = table {attr => "haon" ++ "déag" ; indep => "a" ++ "haon" ++ "déag"} ; size = tenover} ;
lin pot1to19 d =
  {s = table {attr => d.s ! teen ; indep => "a" ++ d.s ! teen } ; size = tenover} ;
lin pot0as1 n =
  {s = table {attr => n.s ! attrib ; indep => "a" ++ n.s ! unit} ; size = n.size} ;
lin pot1 d =
  {s = table {attr => d.s ! twenty ++ AddDeich ! (d.even20) ; 
              indep => d.s ! twenty ++ AddADeich ! (d.even20)} ; 
   size = eventen} ;
lin pot1plus d e =
  {s = table {attr => (d.s ! twenty) ++ e.s ! unit ++ 
                       table {ten => "déag" ; _ => []} ! (d.even20) ; 
	      indep => (d.s ! twenty) ++ "a" ++ e.s ! unit ++ 
                        table {ten => "déag" ; _ => []} ! (d.even20)} ; 
   size = e.size} ;
lin pot1as2 n =
  {s = table {attr => n.s ! attr ; indep => n.s ! indep} ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! attrib ++ EclipseLeniteCead ! d.size} ; size = tenover} ;
lin pot2plus d e =
  {s = table {_ => d.s ! attrib ++ EclipseLeniteCead ! d.size ++ AddIs ! e.size ++ e.s ! indep} ; size = e.size} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ LeniteMile ! n.size} ;
lin pot3plus n m =
  {s = n.s ! attr ++ LeniteMile ! n.size ++ m.s ! indep} ;

oper AddDeich : Even20 => Str = table {ten => "deich" ; _ => []} ;
oper AddADeich : Even20 => Str = table {ten => "a" ++ "deich" ; _ => []} ;
oper AddIs : Size => Str = table {eventen => "is" ; _ => []} ; 
oper EclipseLeniteCead : Size => Str = table {onetosix => "chead" ; seventonine => "gcéad" ; _ => "céad" } ;
oper LeniteMile : Size => Str = table {onetosix => "mhíle" ; _ => "míle" } ;


}
