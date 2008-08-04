concrete guahibo of Numerals = {
-- include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ; 

param Size = sg | pl ;

oper All = {s : Str ; size : Size};

lincat Numeral =    { s : Str } ;
lincat Digit =      All ;
lincat Sub10 =      All ;
lincat Sub100 =     All ;
lincat Sub1000 =    All ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> All = \tri -> 
  { s = tri ; size = pl};

lin num x = {s = x.s } ; 

lin n2 = mkNum "aniha" ;
lin n3 = mkNum "akueya" ;
lin n4 = mkNum "yana" ;
lin n5 = mkNum "kobe" ;
lin n6 = mkNum "ku" ;
lin n7 = mkNum "iwi" ;
lin n8 = mkNum "yu" ;
lin n9 = mkNum "ho" ;

oper ss : Str -> All = \s1 -> {s = s1 ; size = pl } ; 

lin pot01 = { s = "kae" ; size = sg};
lin pot0 d = d ;
lin pot110 = ss "xu" ;
lin pot111 = ss ("xu" + "kae") ;
lin pot1to19 d = ss (bind "xu" d.s) ;
lin pot0as1 n = n ;
lin pot1 d = ss (bind d.s "bae" );
lin pot1plus d e = ss ((bind d.s "bae") ++ e.s ) ;
lin pot1as2 n = n ;
lin pot2 d = ss (bind ((selsg d.s) ! d.size) "sia" ) ;
lin pot2plus d e = ss ((bind ((selsg d.s) ! d.size) "sia") ++ e.s) ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = bind ((selsg n.s) ! n.size) "sunu" } ;
lin pot3plus n m = {s = (bind ((selsg n.s) ! n.size) "sunu") ++ m.s} ;

oper selsg : Str -> Size => Str = \s -> table {sg => [] ; pl => s } ;

}
