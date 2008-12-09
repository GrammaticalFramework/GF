concrete romanian of Numerals = {
flags coding = utf8 ;
-- include numerals.Abs.gf ;
-- flags coding=latinasupplement ;

-- Note [s,], [a%] for Romanian s, and a with up bow ontop (not â)

param DForm = unit | teen | ten | attr ;
param MidForm = indep | det ; 
param Size = sg | less20 | pl ;

lincat Numeral =    { s : Str } ;
oper LinDigit = {s : DForm => Str ; size : Size} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : MidForm => Str ; size : Size} ;
lincat Sub1000 = {s : MidForm => Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> LinDigit = 
  \two -> \twelve -> \twenty -> mkNumSpc two twelve twenty two ;

oper mkNumSpc : Str -> Str -> Str -> Str -> LinDigit = 
  \two -> \twelve -> \twenty -> \doua -> 
  {s = table {unit => two ; teen => twelve ; ten => twenty ; attr => doua} ; size = less20} ;

oper regNum : Str -> LinDigit = 
  \trei -> mkNum trei (trei + variants { "sprezece" ; "şpe" }) (trei + "zeci") ;

oper ss : Str -> {s : MidForm => Str ; size : Size} = \st -> {s = table {_ => st} ; size = less20} ;

lin num x = {s = [] ++ x.s ++ [] }; -- Latin A Supplement chars
lin n2 = mkNumSpc "doi" (variants { "doisprezece" ; "doişpe"}) "douăzeci" "două" ;
lin n3 = regNum "trei" ;
lin n4 = mkNum "patru" (variants{"paisprezece" ; "paişpe"}) "patruzeci" ;
lin n5 = mkNum "cinci" (variants{"cinsprezece" ; "cinşpe"}) "cincizeci";
lin n6 = mkNum "şase" (variants{"şaisprezece" ; "şaişpe"}) "şaizeci" ;
lin n7 = mkNum "şapte" (variants{"şaptesprezece" ; "şaptişpe"}) "şaptezeci" ; 
lin n8 = mkNum "opt" (variants{"optsprezece" ; "optişpe"}) "optzeci" ;
lin n9 = regNum "nouă" ;

lin pot01 = {s = table {attr => "o" ; f => "unu"} ; size = sg} ;
lin pot0 d = d ;
lin pot110 = ss "zece" ;
lin pot111 = ss (variants { "unsprezece" ; "unşpe"}) ;
lin pot1to19 d = {s = table {_ => d.s ! teen } ; size = less20} ;
lin pot0as1 n = {s = table {indep => n.s ! unit ; det => n.s ! attr } ; size = n.size} ;
lin pot1 d = {s = table {_ => d.s ! ten } ; size = pl} ;
lin pot1plus d e = 
  {s = table {indep => d.s ! ten ++ "şi" ++ e.s ! unit ;
              det => d.s ! ten ++ "şi" ++ e.s ! attr } ; 
   size = pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = table {_ => d.s ! attr ++ (mksute d.size) }; size = pl} ;
lin pot2plus d e = 
  {s = table {indep => d.s ! attr ++ (mksute d.size) ++ e.s ! indep;
              det => d.s ! attr ++ (mksute d.size) ++ e.s ! det }; 
   size = pl} ;
lin pot2as3 n = {s = n.s ! indep };
lin pot3 n = {s = (mkmie n.size (n.s ! det) (n.s ! indep))} ;
lin pot3plus n m = {s = (mkmie n.size (n.s ! det) (n.s ! indep)) ++ m.s ! indep} ;

oper mksute : Size -> Str = \sz -> table {sg => "suta" ; _ => "sute" } ! sz ; 
oper mkmie : Size -> Str -> Str -> Str = \sz -> \attr -> \indep -> 
  table {sg => "o" ++ "mie" ;
         less20 => attr ++ "mii" ;
         pl => indep ++ "de" ++ "mii"} ! sz ;

}
