-- Koen Claessen from Deu, 11/1/2001.

include numerals.Abs.gf ;

param DForm = unit  | teen  | ten  ;
param Place = indep  | prae  | attr  ;

lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Str} ;
lincat Sub10 = {s : DForm * Place => Str} ;
lincat Sub100 = {s : Place => Str} ;
lincat Sub1000 = {s : Place => Str} ;
lincat Sub1000000 = {s : Str} ;

oper mkGetal : Str -> Str -> Str -> Lin Digit = 
  \två -> \tolv -> \tjugo -> 
  {s = table {unit => två ; teen => tolv ; ten => tjugo}} ;
oper regGetal : Str -> Lin Digit = 
  \vier -> mkGetal vier (vier + "tien") (vier + "tig") ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin num x = x ;

lin n2 = mkGetal "twee" "twaalf"    "twintig" ;
lin n3 = mkGetal "drie" "dertien" "dertig" ;
lin n4 = mkGetal "vier" "veertien" "veertig";
lin n5 = regGetal "vijf" ;
lin n6 = regGetal "zes" ;
lin n7 = regGetal "zeven" ;
lin n8 = mkGetal "acht" "achttien" "tachtig";
lin n9 = regGetal "negen" ;

lin pot01 = {s = table {<f,indep> => "een" ; <f,prae> => "een" ; <f,attr> => []}} ;
lin pot0 d = {s = table {<f,p> => d.s ! f}} ;
lin pot110 = {s = table {p => "tien"}} ;
lin pot111 = {s = table {p => "elf"}} ;
lin pot1to19 d = {s = table {p => d.s ! teen}} ;
lin pot0as1 n = {s = table {p => n.s ! <unit,p>}} ;
lin pot1 d = {s = table {p => d.s ! ten}} ;
lin pot1plus d e = {s = table {p => e.s ! <unit,prae> ++ "en" ++ d.s ! ten}} ;
lin pot1as2 n = {s = table {p => n.s ! p}} ;
lin pot2 d = {s = table {p => d.s ! <unit,attr> ++ "honderd"}} ;
lin pot2plus d e = {s = table {
        _    => d.s ! <unit,attr> ++ "honderd" ++ e.s ! indep}} ;
lin pot2as3 n = ss (n.s ! indep) ;
lin pot3 n = ss (n.s ! attr ++ "duizend") ;
lin pot3plus n m = ss (n.s ! attr ++ "duizend" ++ m.s ! prae) ;

