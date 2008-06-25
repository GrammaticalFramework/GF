include numerals.Abs.gf ;

param DForm = unit | ten ;
param Size = sg | pl | tenplus ;
param S100 = indep | tenpart | tenelfu | sihpart ;

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str ; size : Size} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
oper LinSub100 = {s : S100 => Str ; size : Size} ;
lincat Sub100 = LinSub100 ; 
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;

oper mkNum : Str -> Str -> LinDigit = \hulatt -> \haya ->
  {s = table {unit => hulatt ; ten => haya} ; size = pl} ;

lin num x0 =
  {s = x0.s } ;
lin n2 = mkNum "hoire" "hori" ; 
lin n3 = mkNum "guarebe" "goci"  ;
lin n4 = mkNum "durube" "duci" ;
lin n5 = mkNum "taau" "tabi" ;
lin n6 = mkNum "jireuoo" "jari" ; 
lin n7 = mkNum "doloo" "dale" ;
lin n8 = mkNum "naime" "nai" ;
lin n9 = mkNum "ise" "ire" ;

oper ss1 : Str -> Str -> Str -> LinSub100 = \assir -> \ten -> \unitpart -> 
  {s = table {indep => assir ; tenpart => ten ; tenelfu => [] ; sihpart => unitpart} ; size = tenplus } ;
  
oper ss : Str -> Str -> Str -> LinSub100 = \assir -> \ten -> \unitpart -> 
  {s = table {indep => assir ; tenpart => ten ; tenelfu => ten ; sihpart => unitpart} ; size = tenplus } ;

lin pot01  =
  {s = table {unit => "neke" ; ten => "harebe" }; size = sg};
lin pot0 d = d ;
lin pot110 = ss1 "harebe" "neke" [] ; 
lin pot111 = ss1 ("hareben" ++ "neke") "neke" "miange" ;
lin pot1to19 d = ss1 ("hareben" ++ d.s ! unit) "neke" (mkmiange d.size (d.s ! unit)) ;
lin pot0as1 n = {s = table {indep => n.s ! unit ; sihpart => mkmiange n.size (n.s ! unit) ; _ => [] } ; size = n.size} ;
lin pot1 d = ss (d.s ! ten) (d.s ! unit) [] ; 
lin pot1plus d e = ss ((d.s ! ten) ++ (e.s ! unit)) 
                      (d.s ! unit) 
                      (mkmiange e.size (e.s ! unit)); 

lin pot1as2 n = {s = n.s ! indep ; s2 = n.s ! tenelfu ++ "tume" ++ n.s ! sihpart ; size = n.size} ;

lin pot2 d = {s = (sel d.size [] (d.s ! unit)) ++ "jau" ; 
	      s2 = sel d.size "harebe" (d.s ! ten) ; size = tenplus} ;
lin pot2plus d e = {s = (sel d.size [] (d.s ! unit)) ++ "jau" ++ e.s ! indep ; s2 = d.s ! ten ++ e.s ! tenpart ++ "tume" ++ e.s ! sihpart ; size = tenplus} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = table {pl => n.s ++ "miange" ; sg => "miange" ; tenplus => n.s2 } ! n.size} ;
lin pot3plus n m = {s = table {pl => n.s ++ "miange" ; sg => "miange" ; tenplus => n.s2 } ! n.size ++ m.s} ;

oper mkmiange : Size -> Str -> Str = \sz -> \attr -> (sel sz [] attr) ++ "miange" ; 

oper sel : Size -> Str -> Str -> Str = \sz -> \a -> \b -> table {sg => a ; _ => b} ! sz ; 