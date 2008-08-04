concrete af_tunni of Numerals = {
-- include numerals.Abs.gf ;

param Size = sg | pl ;
param DForm = unit | ten ;

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
  {s = table {unit => mbili ; ten => lama }; size = pl };

-- lin n1 = mkNum "ków" ; 
lin n2 = mkNum "lámma" "labaatón";
lin n3 = mkNum "síddi?" "soddón" ;
lin n4 = mkNum "áfar" "afartón";
lin n5 = mkNum "s^án" "kontón";
lin n6 = mkNum "lí?" "lihdón";
lin n7 = mkNum "toddóbo" "toddobátan";
lin n8 = mkNum "siyéed" "siyyeétan" ;
lin n9 = mkNum "sagáal" "sagaás^an";

oper ss : Str -> Form = \s1 -> {s = s1 ; size = pl} ;

lin pot01  =
  {s = table {f => "ków" }; size = sg };
lin pot0 d = d ;
lin pot110 = ss "tómon" ; 
lin pot111 = ss ("tómon" ++ "i" ++ "ków") ; 
lin pot1to19 d = ss ("tómon" ++ "i" ++ (d.s ! unit)) ;
lin pot0as1 n = {s = n.s ! unit ; size = n.size } ;
lin pot1 d = ss (d.s ! ten) ;
lin pot1plus d e = ss (d.s ! ten ++ "i" ++ e.s ! unit) ; 
lin pot1as2 n = n ;
lin pot2 d = ss (selsg d.size (d.s ! unit) ++ "boqól" );
lin pot2plus d e = ss ((selsg d.size (d.s ! unit)) ++ "boqól" ++ e.s) ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = (selsg n.size n.s) ++ "kún"} ;
lin pot3plus n m = {s = (selsg n.size n.s) ++ "kún" ++ m.s} ;

oper selsg : Size -> Str -> Str = \sz -> \attr -> 
  table {pl => attr ; sg => [] } ! sz ; 

}
