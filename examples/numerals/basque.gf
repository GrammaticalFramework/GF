concrete basque of Numerals = {
-- include numerals.Abs.gf ;

oper LinDigit = {s : DForm => Str ; even20 : Even20 ; size : Size} ;

oper mk20Ten : Str -> Str -> Str -> Str -> LinDigit = 
  \tri -> \t -> \fiche -> \h -> 
  { s = table {unit => tri ; teen => t ; twenty => fiche ; hund => h + "ehun"} ; even20 = ten ; size = pl} ;

oper mkEven20 : Str -> Str -> Str -> Str -> LinDigit = 
  \se -> \t -> \trifichid -> \h -> 
  { s = table {unit => se ; teen => t ; twenty => trifichid ; hund => h + "ehun"} ; even20 = even ; size = pl} ;

param Even20 = ten | even ;
param DForm = unit | teen | twenty | hund ;
param Size = sg | pl ;
 
lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  = mkEven20 "bi" "hamabi" "hogei" "berr" ; 
lin n3  = mk20Ten "hiru" (variants {"hamahiru" ; "hamahirur"}) "hogei" "hirur";
lin n4  = mkEven20 "lau" (variants {"hamalau" ; "hamalaur"}) "berrogei" "laur";
lin n5  = mk20Ten "bost" (variants {"hamabost" ; "hamabortz"}) "berrogei" "bost"; 
lin n6  = mkEven20 "sei" "hamasei" "hirurogei" "seir" ;
lin n7  = mk20Ten "zazpi" "hamazazpi" "hirurogei" "zazpi" ;
lin n8  = mkEven20 "zortzi" "hemezortzi" "laurogei" "zortzi" ;
lin n9  = mk20Ten "bederatzi" "hemeretzi" "laurogei" "bederatzi" ;

lin pot01  =
  {s = table {unit => "bat" ; hund => "ehun" ; _ => "dummy"} ; even20 = ten ; size = sg};
lin pot0 d = {s = d.s ; even20 = d.even20 ; size = d.size} ;
lin pot110 = {s = "hamar" ; size = pl} ;
lin pot111 = {s = variants {"hamaika" ; "hameka"} ; size = pl} ;
lin pot1to19 d = {s = d.s ! teen ; size = pl} ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size} ;
lin pot1 d =
  {s = table {even => d.s ! twenty ;  
              ten => d.s ! twenty ++ "tahamar"} ! d.even20 ; -- glue
   size = pl} ;
lin pot1plus d e =
  {s = table {even => d.s ! twenty ++ "ta" ++ e.s ! unit;  
              ten => d.s ! twenty ++ "ta" ++ e.s ! teen} ! (d.even20) ; 
   size = pl} ;

lin pot1as2 n = n ; 
lin pot2 d = {s = d.s ! hund ; size = pl} ;
lin pot2plus d e =
  {s = variants {d.s ! hund ++ e.s ; d.s ! hund ++ "ta" ++ e.s} ; size = pl} ;
lin pot2as3 n =
  {s = n.s } ;
lin pot3 n =
  {s = table {sg => [] ; pl => n.s } ! n.size ++ "mila"} ;
lin pot3plus n m =
  {s = table {sg => [] ; pl => n.s } ! n.size ++ "mila" ++ "ta" ++ m.s } ;

}
