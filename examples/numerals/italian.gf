concrete italian of Numerals = {
-- include numerals.Abs.gf ;

param DForm = ental Pred | ton | tiotal  ;
param Num = sg | pl ;
param Pred = pred | indip ;

lincat Numeral =    { s : Str } ;
oper LinDigit = {s : DForm => Str} ;
lincat Digit = LinDigit ;

lincat Sub10 = {s : DForm => Str ; n : Num} ;
lincat Sub100 = {s : Str ; n : Num} ;
lincat Sub1000 = {s : Str ; n : Num} ;
lincat Sub1000000 = {s : Str} ;

oper mkTal : Str -> Str -> Str -> LinDigit = 
  \två -> \tolv -> \tjugo -> 
  {s = table {ental _ => två ; ton => tolv ; tiotal => tjugo}} ;
oper ss : Str -> {s : Str} = \s -> {s = s} ;
oper spl : Str -> {s : Str ; n : Num} = \s -> {s = s ; n = pl} ;
oper mille : Num => Str = table {sg => "mille" ; pl => "mila"} ;

lin num x = x ;

lin n2 = mkTal "due"  "dodici"    "venti" ;
lin n3 = mkTal "tre"  "tredici" "trenta" ;
lin n4 = mkTal "quattro" "quattordici" "quaranta" ;
lin n5 = mkTal "cinque" "quindici" "cinquanta" ;
lin n6 = mkTal "sei" "sedici" "sessanta" ;
lin n7 = mkTal "sette"  "diciassette" "settanta" ;
lin n8 = mkTal "otto" "diciotto"   "ottanta" ;
lin n9 = mkTal "nove"  "diciannove"   "novanta" ;

lin pot01 = {s = table {ental pred => [] ; _  => "uno"} ; n = sg} ;
lin pot0 d = {s = table {f => d.s ! f} ; n = pl} ;
lin pot110 = spl "dieci" ;
lin pot111 = spl "undici" ;
lin pot1to19 d = spl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental indip ; n = n.n} ;
lin pot1 d = spl (d.s ! tiotal) ;
lin pot1plus d e = spl (d.s ! tiotal ++ e.s ! ental indip) ;
lin pot1as2 n =  {s = n.s ; n = n.n} ;
lin pot2 d = spl (d.s ! ental pred ++ "cento") ;
lin pot2plus d e = spl (d.s ! ental pred ++ "cento" ++ e.s) ;
lin pot2as3 n = {s = n.s ; n = n.n}  ;
lin pot3 n = ss (n.s ++ mille ! n.n) ;
lin pot3plus n m = ss (n.s ++ mille ! n.n ++ m.s) ;


}
