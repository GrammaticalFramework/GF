include numerals.Abs.gf ;

param DForm = unit | teen | ten | hundred | veinti ;
param Size = sg | two | pl ;
param Uso = indep | attr ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str ; size : Size } ;
lincat Sub10 = {s : DForm => Str ; size : Size } ;
lincat Sub100 = {s : Uso => Str ; size : Size} ;
lincat Sub1000 = {s : Uso => Str ; size : Size} ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> Str -> Str -> Str -> Lin Digit = 
  \dois -> \doze -> \vinte -> \duzentos -> 
  {s = table {unit => dois ; teen => doze ; ten => vinte ; hundred => duzentos ;veinti => "veinti" + dois } ; size = pl} ;


lin num x0 =
  {s = x0.s} ;

lin n2 = {s = table {unit => "dos" ; teen => "doce" ; ten => "veinte" ; hundred => "doscientos" ; veinti => "veinti" + "dos" } ; size = two } ; 
lin n3 = mkNum "tres" "trece" "treinta" "trescientos" ;
lin n4 = mkNum "cuatro" "catorce" "cuarenta" "cuatrocientos" ;
lin n5 = mkNum "cinco" "quince" "cincuenta" "quinientos" ;
lin n6 = {s = table {unit => "seis" ; teen => "dieciseís" ; ten => "sesenta" ; hundred => "seiscientos" ; veinti => "veinti" + "seís" } ; size = pl } ;
lin n7 = mkNum "siete" "diecisiete" "setenta" "setecientos" ;
lin n8 = mkNum "ocho" "dieciocho" "ochenta" "ochocientos" ;
lin n9 = mkNum "nueve" "diecinueve" "noventa" "novecientos" ;

lin pot01  = {s = table {unit => "uno" ; hundred => "cien" ; veinti => "veinti" + "uno" ; _ => "dummy"} ; size = sg} ;
lin pot0 d = d ; 
lin pot110 =
  {s = table {_ => "diez" } ; size = pl} ;
lin pot111  =
  {s = table {_ => "once" } ; size = pl} ;
lin pot1to19 d =
  {s = table {_ => d.s ! teen } ; size = pl} ;
lin pot0as1 n =
  {s = table {indep => n.s ! unit ; attr => shorten (n.s ! unit) n.size }; size = n.size } ;
lin pot1 d =
  {s = table {_ => d.s ! ten } ; size = pl} ;
lin pot1plus d e =
  {s = table {indep => table {two => e.s ! veinti ; _ => d.s ! ten ++ "y" ++ e.s ! unit} ! d.size ; attr => table {two => accent (e.s ! veinti) e.size ; _ => d.s ! ten ++ "y" ++ (shorten (e.s ! unit) e.size)} ! d.size } ; size = pl} ;  
lin pot1as2 n =
  {s = table {f => n.s ! f } ; size = n.size} ;
lin pot2 d =
  {s = table {_ => d.s ! hundred } ; size = pl} ;  
lin pot2plus d e =
  {s = table {f => table {sg => "ciento" ;  
                          _ => d.s ! hundred } ! d.size ++ e.s ! f} ; size = pl} ;
lin pot2as3 n =
  {s = n.s ! indep } ;
lin pot3 n =
  {s = table {sg => "mil" ; _ => n.s ! attr ++ "mil"} ! n.size} ;
lin pot3plus n m =
  {s = table {sg => "mil" ; _ => n.s ! attr ++ "mil"} ! n.size ++ m.s ! indep} ;

oper accent : Str -> Size -> Str = \s -> \sz -> 
  table {sg => "veintiún" ; _ => s} ! sz ;

oper shorten : Str -> Size -> Str = \s -> \sz -> 
  table {sg => "un" ; _ => s} ! sz ;