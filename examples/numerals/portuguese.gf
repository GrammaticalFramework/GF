include numerals.Abs.gf ;

param DForm = unit | teen | ten | hundred ;
param Size = sg | less10 | pl ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size } ;
lincat Sub10 = {s : DForm => Str ; size : Size } ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> Str -> Str -> Str -> Lin Digit = 
  \dois -> \doze -> \vinte -> \duzentos -> 
  {s = table {unit => dois ; teen => doze ; ten => vinte ; hundred => duzentos} ; size = less10} ;


lin num x0 =
  {s = x0.s} ;

lin n2 = mkNum "dois" "doze" "vinte" "duzentos" ;
lin n3 = mkNum "três" "treze" "trinta" "trezentos" ;
lin n4 = mkNum "cuatro" (variants {"catorze" ; "quatorze"}) "quarenta" "cuatrocentos" ;
lin n5 = mkNum "cinco" "quinze" "cinqüenta" "quinhentos" ;
lin n6 = mkNum "seis" (variants {"dezasseis" ; "dezesseis"}) "sessenta" "seiscentos" ;
lin n7 = mkNum "sete" (variants {"dezassete" ; "dezessete"}) "setenta" "setecentos" ;
lin n8 = mkNum "oito" "dezoito" "oitenta" "oitocentos" ;
lin n9 = mkNum "nove" (variants {"dezanove" ; "dezenove"}) "noventa" "novecentos" ;

lin pot01  = {s = table {unit => "um" ; hundred => "cem" ; _ => "dummy"} ; size = sg} ;
lin pot0 d = d ; 
lin pot110 =
  {s = "dez" ; size = pl} ;
lin pot111  =
  {s = "onze" ; size = pl} ;
lin pot1to19 d =
  {s = d.s ! teen ; size = pl} ;
lin pot0as1 n =
  {s = n.s ! unit ; size = n.size } ;
lin pot1 d =
  {s = d.s ! ten ; size = pl} ;
lin pot1plus d e =
  {s = d.s ! ten ++ "e" ++ e.s ! unit ; size = pl} ;  
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = d.s ! hundred ; size = pl} ;  
lin pot2plus d e =
  {s = table {sg => "cento" ;  
              _ => d.s ! hundred } ! d.size ++ (add e.s) ! e.size ; size = pl} ;
lin pot2as3 n =
  {s = n.s} ;
lin pot3 n =
  {s = table {sg => "mil" ; _ => n.s ++ "mil"} ! n.size} ;
lin pot3plus n m =
  {s = table {sg => "mil" ; _ => n.s ++ "mil"} ! n.size ++ (add m.s) ! m.size } ;

oper add : Str -> Size => Str = \s -> table {pl => s ; _ => "e" ++ s}; 