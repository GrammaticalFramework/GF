concrete tukang_besi of Numerals = {
-- include numerals.Abs.gf ;

param DForm = u | v ;

oper LinDigit = {s : DForm => Str } ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = LinDigit ;
lincat Sub1000 = LinDigit ;
lincat Sub1000000 = { s : Str } ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ;

oper mkNum : Str -> LinDigit = \a -> {s = table {_ => a}} ;
oper mkNum2 : Str -> Str -> LinDigit = \a -> \b -> {s = table {u => a ; v => b}} ;

lin num x = x ;
-- lin n1 mkNum "sa'asa" ;
lin n2 = mkNum "dua" ;
lin n3 = mkNum "tolu" ;
lin n4 = mkNum2 "gana" "hato";
lin n5 = mkNum "lima" ;
lin n6 = mkNum2 "no'o" "nomo" ;
lin n7 = mkNum2 "pitu" "hitu" ;
lin n8 = mkNum "alu" ;
lin n9 = mkNum "sia" ;

lin pot01 = mkNum2 "sa'asa" "sa" ;
lin pot0 d = d ; 
lin pot110 = {s = table {_ => "ompulu" }}; 
lin pot111 = {s = table {u => "ompulu" ++ "sa'asa" ; v => "ompulu" ++ "sa"}} ;
lin pot1to19 d = {s = table {f => "ompulu" ++ d.s ! f}} ;
lin pot0as1 n = n ;
lin pot1 d = {s = table {_ => bind (d.s ! v) "hulu" }} ;
lin pot1plus d e = {s = table {f => (bind (d.s ! v) "hulu") ++ e.s ! f}} ;
lin pot1as2 n = n ;
lin pot2 d = {s = table {_ => bind (d.s ! v) "hatu" }} ;
lin pot2plus d e = {s = table {f => (bind (d.s ! v) "hatu") ++ e.s ! f}} ;
lin pot2as3 n = {s = n.s ! u};
lin pot3 n = {s = bind (n.s ! v) "riwu" } ;
lin pot3plus n m = {s = (bind (n.s ! v) "riwu") ++ m.s ! u } ;

}
