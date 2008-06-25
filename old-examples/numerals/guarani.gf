include numerals.Abs.gf ;

oper bind : Str -> Str -> Str = \a -> \b -> a ++ b ; 

param Size = sg | pl ;

oper All = {s : Str ; s2 : Str ; size : Size};

lincat Numeral =    { s : Str } ;
lincat Digit =      All ;
lincat Sub10 =      All ;
lincat Sub100 =     {s : Str ; size : Size} ;
lincat Sub1000 =    {s : Str ; size : Size} ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> All = \tri -> 
  { s = tri ; s2 = "kua" + tri ; size = pl};

oper mkNum2 : Str -> Str -> All = \tri -> \teen -> 
  { s = tri ; s2 = "kua" + teen ; size = pl};

lin num x = {s = x.s } ; -- TODO

lin n2 = mkNum2 "moko~i" "ko~i";
lin n3 = mkNum2 "mpohapy" "py";
lin n4 = mkNum2 "irundy" "rundy";
lin n5 = mkNum "po" ;
lin n6 = mkNum "potei~" ;
lin n7 = mkNum "poko~i" ;
lin n8 = mkNum "poapy" ;
lin n9 = mkNum "porundy" ;

oper ss : Str -> {s : Str ; size : Size} = \s1 -> {s = s1 ; size = pl } ; 

lin pot01 = { s = "petei~" ; s2 = "dummy" ; size = sg};
lin pot0 d = d ;
lin pot110 = ss "kua~" ;
lin pot111 = ss ("kua" + "tei~") ;
lin pot1to19 d = ss d.s2 ;
lin pot0as1 n = {s = n.s ; size = n.size} ;
lin pot1 d = ss (bind d.s "kua~" );
lin pot1plus d e = ss ((bind d.s "kua~") ++ e.s ) ;
lin pot1as2 n = n ;
lin pot2 d = ss (((selsg d.s) ! d.size) ++ "sa~" ) ;
lin pot2plus d e = ss ((((selsg d.s) ! d.size) ++ "sa~") ++ e.s) ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = bind ((selsg n.s) ! n.size) "ma" } ;
lin pot3plus n m = {s = (bind ((selsg n.s) ! n.size) "ma") ++ m.s} ;

oper selsg : Str -> Size => Str = \s -> table {sg => variants {[]; "petei~"}; pl => s } ;