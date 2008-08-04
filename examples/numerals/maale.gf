concrete maale of Numerals = {
-- include numerals.Abs.gf ;

param Size = sg | pl ;
param DForm = unit | ten ;

oper LinDigit = {s : DForm => Str ; size : Size } ;
oper Form = {s : Str ; size : Size } ;

lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = Form ;
lincat Sub1000 = {s : Str} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO: Encoding

oper mkNum : Str -> Str -> LinDigit = \mbili -> \lama ->
  {s = table {unit => mbili ; ten => lama + "-támmi" }; size = pl };

-- b> is b with right bend
-- ? without dot
-- $ IPA [sh]

-- lin n1 = mkNum "pétte" ; 
lin n2 = mkNum "lam?ó" "lamá";
lin n3 = mkNum "haitsó" "haytsí" ;
lin n4 = mkNum "?oidó" "?oydí";
lin n5 = mkNum "dóngo" "dóngi";
lin n6 = mkNum "láhhó" "láhhi";
lin n7 = mkNum "lánkayi" "lánkayi";
lin n8 = mkNum "sálli" "sálli" ;
lin n9 = mkNum "tásub>a" "tázub>i";

oper ss : Str -> Form = \s1 -> {s = s1 ; size = pl} ;

lin pot01  =
  {s = table {f => "pétte" }; size = sg };
lin pot0 d = d ;
lin pot110 = ss "táb>b>ó" ; 
lin pot111 = ss ("táb>b>ó" ++ "pétte") ; 
lin pot1to19 d = ss ("táb>b>ó" ++ (d.s ! unit)) ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size } ;
lin pot1 d = ss (d.s ! ten) ;
lin pot1plus d e = ss (d.s ! ten ++ e.s ! unit) ; 
lin pot1as2 n = n ;
lin pot2 d = {s = mkseeta d.size (d.s ! unit) };
lin pot2plus d e = {s = (mkseeta d.size (d.s ! unit)) ++ e.s} ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = n.s ++ "$íya"} ;
lin pot3plus n m = {s = n.s ++ "$íya" ++ m.s} ;

oper mkseeta : Size -> Str -> Str = \sz -> \attr -> 
  table {pl => attr ++ "s'ééta" ; 
         sg => "s'ééta" } ! sz ; 

}
