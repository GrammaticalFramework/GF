include numerals.Abs.gf ;

oper na = {s = "N/A" };

param DForm = u | teen ;

oper LinDigit = {s : DForm => Str } ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str } ;
lincat Sub1000 = {s : Str } ;
lincat Sub1000000 = { s : Str } ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ;

oper mkNum : Str -> LinDigit = \a -> 
 {s = table {u => a ; teen => "kun'il" ++ a ++ "budie"}} ;
oper mkNum2 : Str -> Str -> LinDigit = \a -> \b -> 
 {s = table {u => a ; teen => b ++ "budie"}} ;

lin num x = x ;
-- lin n1 mkNum "irkin" ;
lin n2 = mkNum2 "ataqun" ("kun" ++ "ataqun") ;
lin n3 = mkNum2 "ja:n" ("kun'il" ++ "ja:l");
lin n4 = mkNum "ilekun" ;
lin n5 = mkNum "n'ahanbo:d'e" ;
lin n6 = mkNum "malha:n" ;
lin n7 = mkNum "purki:n" ;
lin n8 = mkNum "malhi:lek" ;
lin n9 = mkNum "kunirkil'd'o:j" ;

lin pot01 = mkNum2 "irkin" ("kun" ++ "irku");
lin pot0 d = d ; 
lin pot110 = {s = "kun'in"}; 
lin pot111 = {s = ("kun" ++ "irkubudie")} ;
lin pot1to19 d = {s = d.s ! teen} ;
lin pot0as1 n = {s = n.s ! u} ;
lin pot1 d = {s = d.s ! u ++ "kun'el"} ;
lin pot1plus d e = {s = d.s ! u ++ "kun'el" ++ e.s ! u};
lin pot1as2 n = n ;
lin pot2 d = {s = "kun'in" ++ "kun'in" ++ d.s ! u ++ "budie"} ;
lin pot2plus d e = {s = "kun'in" ++ "kun'in" ++ d.s ! u ++ "budie" ++ e.s } ;
lin pot2as3 n = n ;
lin pot3 n = na ;
lin pot3plus n m = na ;
