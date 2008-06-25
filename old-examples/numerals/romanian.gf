include numerals.Abs.gf ;
flags coding=latinasupplement ;

-- Note [s,], [a%] for Romanian s, and a with up bow ontop (not â)

param DForm = unit | teen | ten | attr ;
param MidForm = indep | det ; 
param Size = sg | less20 | pl ;

lincat Numeral =    { s : Str } ;
lincat Digit = {s : DForm => Str ; size : Size} ;
lincat Sub10 = {s : DForm => Str ; size : Size} ;
lincat Sub100 = {s : MidForm => Str ; size : Size} ;
lincat Sub1000 = {s : MidForm => Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> Lin Digit = 
  \two -> \twelve -> \twenty -> mkNumSpc two twelve twenty two ;

oper mkNumSpc : Str -> Str -> Str -> Str -> Lin Digit = 
  \two -> \twelve -> \twenty -> \doua -> 
  {s = table {unit => two ; teen => twelve ; ten => twenty ; attr => doua} ; size = less20} ;

oper regNum : Str -> Lin Digit = 
  \trei -> mkNum trei (trei + variants { "sprezece" ; "s,pe" }) (trei + "zeci") ;

oper ss : Str -> {s : MidForm => Str ; size : Size} = \st -> {s = table {_ => st} ; size = less20} ;

lin num x = {s = "/L" ++ x.s ++ "L/" }; -- Latin A Supplement chars
lin n2 = mkNumSpc "doi" (variants { "doisprezece" ; "doua%sprezece" }) "doua%zeci" "doua%" ;
lin n3 = regNum "trei" ;
lin n4 = mkNum "patru" (variants{"paisprezece" ; "pais,pe"}) "patruzeci" ;
lin n5 = mkNumSpc "cinci" (variants{"cinsprezece" ; "cins,pe"}) "cinzeci" (variants { "cinci" ; "cin" });
lin n6 = mkNum "s,ase" (variants{"s,aisprezece" ; "s,aispe"}) "s,aizeci" ;
lin n7 = mkNum "s,apte" (variants{"s,aptesprezece" ; "s,apspe"}) "s,aptezeci" ; 
lin n8 = mkNum "opt" (variants{"optsprezece" ; "opspe"}) "optzeci" ;
lin n9 = regNum "noua%" ;

lin pot01 = {s = table {attr => "o" ; f => "unu"} ; size = sg} ;
lin pot0 d = d ;
lin pot110 = ss "zece" ;
lin pot111 = ss (variants { "unsprezece" ; "uns,pe"}) ;
lin pot1to19 d = {s = table {_ => d.s ! teen } ; size = less20} ;
lin pot0as1 n = {s = table {indep => n.s ! unit ; det => n.s ! attr } ; size = n.size} ;
lin pot1 d = {s = table {_ => d.s ! ten } ; size = pl} ;
lin pot1plus d e = 
  {s = table {indep => d.s ! ten ++ "s,i" ++ e.s ! unit ;
              det => d.s ! ten ++ "s,i" ++ e.s ! attr } ; 
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
