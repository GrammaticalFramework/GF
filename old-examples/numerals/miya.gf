include numerals.Abs.gf ;

param Size = sg | pl ;
param DForm = unit | acc ;

oper LinDigit = {s : DForm => Str ; size : Size } ;
oper Form = {s : Str ; size : Size } ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = Form ;
lincat Sub1000 = Form ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO: Encoding

oper mkNum : Str -> Str -> LinDigit = \mbili -> \lama ->
  {s = table {unit => mbili ; acc => lama }; size = pl };

-- lin n1 = mkNum "wút`&" ; 
lin n2 = mkNum "ts`&r" "ts'&r";
lin n3 = mkNum "kìdi" "kídì" ;
lin n4 = mkNum "f`&d>&" "f'&d>&";
lin n5 = mkNum "vàatl&" "vaatl&";
lin n6 = mkNum "màaha" "máahà";
lin n7 = mkNum "màats&r" "máats`&r";
lin n8 = mkNum "f´&rf´&d>&" "f`&rf´&d>&" ; 
lin n9 = mkNum "kùciya" "kúcìya";

oper ss : Str -> Form = \s1 -> {s = s1 ; size = pl} ;
oper behan = "bèh&n" ;
oper enaa = "'`&náa" ;

lin pot01  =
  {s = table {unit => "wút`&" ; acc => "wut'&"}; size = sg };
lin pot0 d = d ;
lin pot110 = ss "d'&rb>itim" ; 
lin pot111 = ss (variants {behan ++ "wut'&";"d'&rb>itim" ++ behan ++ "wut'&"});
lin pot1to19 d = ss (variants {behan ++ (d.s ! acc); "d'&rb>itim" ++ behan ++ d.s ! acc}) ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size } ;
lin pot1 d = ss ("díb>i" ++ d.s ! unit) ;
lin pot1plus d e = ss ("díb>i" ++ d.s ! unit ++ behan ++ e.s ! acc) ; 
lin pot1as2 n = n ;
lin pot2 d = ss ("d>àriy" ++ selsg d.size (d.s ! unit));
lin pot2plus d e = ss ("d>àriy" ++ (selsg d.size (d.s ! unit)) ++ enaa ++ e.s);
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = "d'&bu" ++ (selsg n.size n.s)} ;
lin pot3plus n m = {s = "d'&bu" ++ (selsg n.size n.s) ++ enaa ++ m.s} ;

oper selsg : Size -> Str -> Str = \sz -> \attr -> 
  table {pl => attr ; sg => variants {[] ; attr} } ! sz ; 

