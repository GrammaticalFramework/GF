include numerals.Abs.gf ;
flags coding=latinasupplement ;

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
  {s = "/L" ++ x0.s ++ "L/"} ;
lin n2 = mkNum "qoyar" "qorin" ; 
lin n3 = mkNum "Gurban" "guc^in"  ;
lin n4 = mkNum "dörbän" "döc^in" ;
lin n5 = mkNum "tabun" "tabin" ;
lin n6 = mkNum "j^irGu'an" "j^irin" ; 
lin n7 = mkNum "dolo'an" "dalan" ;
lin n8 = mkNum "naiman" "nayan" ;
lin n9 = mkNum "yisün" "j^arin" ;

oper ss1 : Str -> Str -> Str -> LinSub100 = \assir -> \ten -> \unitpart -> 
  {s = table {indep => assir ; tenpart => ten ; tenelfu => [] ; sihpart => unitpart} ; size = tenplus } ;
  
oper ss : Str -> Str -> Str -> LinSub100 = \assir -> \ten -> \unitpart -> 
  {s = table {indep => assir ; tenpart => ten ; tenelfu => ten ; sihpart => unitpart} ; size = tenplus } ;

lin pot01  =
  {s = table {unit => "nigän" ; ten => "arban" }; size = sg};
lin pot0 d = d ;
lin pot110 = ss1 "arban" "nigän" [] ; 
lin pot111 = ss1 ("arban" ++ "nigän") "nigän" "mingGan" ;
lin pot1to19 d = ss1 ("arban" ++ d.s ! unit) "nigän" (mkmingGan d.size (d.s ! unit)) ;
lin pot0as1 n = {s = table {indep => n.s ! unit ; sihpart => mkmingGan n.size (n.s ! unit) ; _ => [] } ; size = n.size} ;
lin pot1 d = ss (d.s ! ten) (d.s ! unit) [] ; 
lin pot1plus d e = ss ((d.s ! ten) ++ (e.s ! unit)) 
                      (d.s ! unit) 
                      (mkmingGan e.size (e.s ! unit)); 

lin pot1as2 n = {s = n.s ! indep ; s2 = n.s ! tenelfu ++ "tümän" ++ n.s ! sihpart ; size = n.size} ;

lin pot2 d = {s = (sel d.size [] (d.s ! unit)) ++ "j^a'un" ; 
	      s2 = sel d.size "arban" (d.s ! ten) ; size = tenplus} ;
lin pot2plus d e = {s = (sel d.size [] (d.s ! unit)) ++ "j^a'un" ++ e.s ! indep ; s2 = d.s ! ten ++ e.s ! tenpart ++ "tümän" ++ e.s ! sihpart ; size = tenplus} ;
lin pot2as3 n = {s = n.s} ;
lin pot3 n = {s = table {pl => n.s ++ "mingGan" ; sg => "mingGan" ; tenplus => n.s2 } ! n.size} ;
lin pot3plus n m = {s = table {pl => n.s ++ "mingGan" ; sg => "mingGan" ; tenplus => n.s2 } ! n.size ++ m.s} ;

oper mkmingGan : Size -> Str -> Str = \sz -> \attr -> (sel sz [] attr) ++ "mingGan" ; 

oper sel : Size -> Str -> Str -> Str = \sz -> \a -> \b -> table {sg => a ; _ => b} ! sz ; 