include numerals.Abs.gf ;

oper LinDigit = {s : DForm => Str ; even20 : Even20 ; size : Size} ;

oper mk20Ten : Str -> Str -> LinDigit = \tri -> \tw -> 
  {s = table {unit => tri ; teen => "turma-" + tri ; twenty => tw+"-áltar"} ; 
   even20 = ten ; size = pl} ;

oper mkEven20 : Str -> Str -> LinDigit = \tri -> \tw ->
  {s = table {unit => tri ; teen => "turma-" + tri ; twenty => tw+"-áltar"} ; 
   even20 = even ; size = pl} ;

param Even20 = ten | even ;
param DForm = unit | teen | twenty ;
param Size = sg | pl ;
 
lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2 = {s = table {unit => "altó" ; teen => "turma-" + "altó" ; twenty => "áltar" } ; even20 = even ; size = pl} ;
lin n3  = {s = table {unit => "iskí" ; teen => "turma-" + "iskí" ; twenty => "áltar" } ; even20 = ten ; size = pl} ;
lin n4  = mkEven20 "wálte" "altó";
lin n5  = mk20Ten "cendí" "altó";
lin n6  = mkEven20 "bis'índe" "iskí" ;
lin n7  = mk20Ten "thalé" "iskí";
lin n8  = mkEven20 "altámbe" "wálte";
lin n9  = mk20Ten "hutí" "wálte";

lin pot01  =
  {s = table {unit => "hek" ; teen => "turma-" + "hék" ; twenty => []} ; even20 = ten ; size = sg};
lin pot0 d = d ; 
lin pot110 = {s = "tórum" ; size = pl} ;
lin pot111 = {s = "turma-" + "hék" ; size = pl} ;
lin pot1to19 d = {s = d.s ! teen ; size = pl} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d =
  {s = table {even => d.s ! twenty ;  
              ten => d.s ! twenty ++ "tórum"} ! d.even20 ;
   size = pl} ;
lin pot1plus d e =
  {s = table {even => d.s ! twenty ++ e.s ! unit;  
              ten => d.s ! twenty ++ e.s ! teen} ! (d.even20) ; 
   size = pl} ;

lin pot1as2 n = n ; 
lin pot2 d = {s = (selsg d.size (d.s ! unit)) ++ "tha" ; size = pl} ;
lin pot2plus d e =
  {s = (selsg d.size (d.s ! unit)) ++ "tha" ++ e.s ; size = pl} ;
lin pot2as3 n =
  {s = n.s } ;
lin pot3 n =
  {s = selsg n.size n.s ++ "hazár"} ;
lin pot3plus n m =
  {s = selsg n.size n.s ++ "hazár" ++ m.s } ;

oper selsg : Size -> Str -> Str = \sz -> \attr ->
  table {sg => [] ; _ => attr} ! sz ;