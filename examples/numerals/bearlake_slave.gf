include numerals.Abs.gf ;

param DForm = unit | hundred ;

oper LinDigit = {s : Str } ;

lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str } ;
lincat Sub1000 = {s : Str } ; 

oper mkNum : Str -> LinDigit = \two ->  
  {s = two } ;

-- TODO: Transl.

lin num x = x ;
-- lin n1 mkNum "l-ée" ;
lin n2 = mkNum "nákee" ;
lin n3 = mkNum "tai" ;
lin n4 = mkNum "di,i," ;
lin n5 = mkNum "so,lái" ;
lin n6 = mkNum "?ehts'é,tai" ;
lin n7 = mkNum "l-á,hdi,i," ;
lin n8 = mkNum "?ehts'é,di,i," ;
lin n9 = mkNum "l-óto," ;

oper o : Str = "?ó," ; 

lin pot01 = {s = "l-ée" } ;
lin pot0 d = d ; 
lin pot110 = {s = variants {"honéno," ; "hóno" }} ;
lin pot111 = {s = variants {"honéno," ; "hóno" } ++ o ++ "l-ée" } ;
lin pot1to19 d = {s = (variants {"honéno," ; "hóno" }) ++ o ++ d.s } ;  
lin pot0as1 n = n ;
lin pot1 d = {s = d.s ++ (variants {"honéno," ; "óno,"})} ;
lin pot1plus d e = {s = d.s ++ (variants {"honéno," ; "óno,"}) ++ o ++ e.s } ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ++ "lak'o, óno,"} ;
lin pot2plus d e = {s = d.s ++ "lak'o, óno," ++ e.s} ;
lin pot2as3 n = n ;
lin pot3 n = {s = n.s ++ "lamíl"} ;
lin pot3plus n m = {s = n.s ++ "lamíl" ++ m.s } ;

