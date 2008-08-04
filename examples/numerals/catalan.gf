concrete catalan of Numerals = {
-- include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \s1 -> \s2 -> s1 ++ s2 ;

param DForm = unit | teen | ten | hundred | vint | null ;
param Size = sg | two | pl ;

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str ; size : Size } ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; size : Size } ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> Str -> Str -> LinDigit = 
  \dois -> \doze -> \vinte -> 
  {s = table {unit => dois ; teen => doze ; ten => vinte ; hundred => dois + "-" + "cents" ; vint => "vint-i-" + dois ; null => [] } ; size = pl} ;

lin num x0 =
  {s = x0.s} ;

lin n2 = {s = table {unit => "dos" ; teen => "dotze" ; ten => "vint" ;
hundred => "dos-cents" ; vint => "vint-i-" + "dos" ; null => []} ; size = two } ; 
lin n3 = mkNum "tres" "tretze" "trenta" ;
lin n4 = mkNum "quatre" "catorze" "quaranta" ;
lin n5 = mkNum "cinc" "quinze" "cinqanta" ;
lin n6 = mkNum "sis" "setze" "seixanta" ;
lin n7 = mkNum "set" "disset" "setanta" ;
lin n8 = mkNum "vuit" "divuit" "vuitanta" ;
lin n9 = mkNum "nou" "dinou" "noranta" ;

lin pot01  = {s = table {unit => "u" ; hundred => "cent" ; vint => "vint-i-" + "u" ; _ => "dummy"} ; size = sg} ;
lin pot0 d = d ; 
lin pot110 =
  {s = "deu" ; size = pl} ;
lin pot111  =
  {s = "onze" ; size = pl} ;
lin pot1to19 d =
  {s = d.s ! teen ; size = pl} ;
lin pot0as1 n =
  {s = n.s ! unit ; size = n.size } ;
lin pot1 d =
  {s = d.s ! ten ; size = pl} ;
lin pot1plus d e =
  {s = table {two => e.s ! vint ++ d.s ! null ; _ => bind (bind (d.s ! ten) "-") (e.s ! unit) } ! d.size ; size = pl} ;  
--{s = table {two => e.s ! vint ; _ => bind (bind (d.s ! ten) "-") (e.s ! unit) } ! d.size ; size = pl} ;  
lin pot1as2 n = n ;
lin pot2 d =
  {s = d.s ! hundred ; size = pl} ;  
lin pot2plus d e =
  {s = d.s ! hundred ++ e.s ; size = pl} ;
lin pot2as3 n =
  {s = n.s } ;
lin pot3 n =
  {s = table {sg => "mil" ; _ => n.s ++ "mil"} ! n.size} ;
lin pot3plus n m =
  {s = table {sg => "mil" ; _ => n.s ++ "mil"} ! n.size ++ m.s } ;


}
