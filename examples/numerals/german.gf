include numerals.Abs.gf ;

param DForm = unit  | teen  | ten  ;
param Place = indep  | prae  | attr  ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm*Place => Str} ;
lincat Sub100 = {s : Place => Str} ;
lincat Sub1000 = {s : Place => Str} ;
lincat Sub1000000 = {s : Str} ;

oper mkZahl : Str -> Str -> Str -> Lin Digit = 
  \två -> \tolv -> \tjugo -> 
  {s = table {unit => två ; teen => tolv ; ten => tjugo}} ;
oper regZahl : Str -> Lin Digit = 
  \vier -> mkZahl vier (vier + "zehn") (vier + "zig") ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin num x = x ;

lin n2 = mkZahl "zwei" "zwölf"    "zwanzig" ;
lin n3 = mkZahl "drei" "dreizehn" "dreissig" ;
lin n4 = regZahl "vier" ;
lin n5 = regZahl "fünf" ;
lin n6 = regZahl "sechs" ;
lin n7 = mkZahl "sieben" "siebzehn" "siebzig" ;
lin n8 = regZahl "acht" ;
lin n9 = regZahl "neun" ;

lin pot01 = {s = table {<f,indep> => "eins" ; <f,prae> => "ein" ; <f,attr> => []}} ;
lin pot0 d = {s = table {<f,p> => d.s ! f}} ;
lin pot110 = {s = table {p => "zehn"}} ;
lin pot111 = {s = table {p => "elf"}} ;
lin pot1to19 d = {s = table {p => d.s ! teen}} ;
lin pot0as1 n = {s = table {p => n.s ! <unit,p>}} ;
lin pot1 d = {s = table {p => d.s ! ten}} ;
lin pot1plus d e = {s = table {p => e.s ! <unit,prae> ++ "und" ++ d.s ! ten}} ;
lin pot1as2 n = {s = table {p => n.s ! p}} ;
lin pot2 d = {s = table {p => d.s ! <unit,attr> ++ "hundert"}} ;
lin pot2plus d e = {s = table {
        attr => d.s ! <unit,attr> ++ "hundert" ++ e.s ! prae ; 
        _    => d.s ! <unit,attr> ++ "hundert" ++ e.s ! indep}} ;
lin pot2as3 n = ss (n.s ! indep) ;
lin pot3 n = ss (n.s ! attr ++ "tausend") ;
lin pot3plus n m = ss (n.s ! attr ++ "tausend" ++ m.s ! prae) ;

