include numerals.Abs.gf ;

param Size = sg | pl ;

oper All = {s : Str ; size : Size};

lincat Digit =      All ;
lincat Sub10 =      All ;
lincat Sub100 =     All ;
lincat Sub1000 =    All ;

oper mkNum : Str -> All = \tri -> 
  { s = tri ; size = pl};

lin num x = {s = x.s } ; 

lin n2 = mkNum "epu" ;
lin n3 = mkNum "külá" ;
lin n4 = mkNum "meli" ;
lin n5 = mkNum "kechu" ;
lin n6 = mkNum "kayu" ;
lin n7 = mkNum "reqle" ;
lin n8 = mkNum "pura" ;
lin n9 = mkNum "aylla" ;

oper ss : Str -> All = \s1 -> {s = s1 ; size = pl } ; 

lin pot01 = { s = "kiñe" ; size = sg};
lin pot0 d = d ;
lin pot110 = ss "mari" ;
lin pot111 = ss ("mari" ++ "kiñe") ;
lin pot1to19 d = ss ("mari" ++ d.s );
lin pot0as1 n = n ;
lin pot1 d = ss (d.s ++ "mari" );
lin pot1plus d e = ss (d.s ++ "mari" ++ e.s ) ;
lin pot1as2 n = n ;
lin pot2 d = ss (((selsg d.s) ! d.size) ++ "pataka" ) ;
lin pot2plus d e = ss (((selsg d.s) ! d.size) ++ "pataka" ++ e.s) ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = (selsg n.s) ! n.size ++ "warangka" } ;
lin pot3plus n m = {s = (selsg n.s) ! n.size ++ "warangka" ++ m.s} ;

oper selsg : Str -> Size => Str = \s -> table {sg => [] ; pl => s } ;