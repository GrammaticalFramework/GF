include numerals.Abs.gf ;

param Size = sg | two | pl ;

oper Form = {s : Str ; size : Size} ;

lincat Numeral =    { s : Str } ;
lincat Digit = Form ;
lincat Sub10 = Form ;
lincat Sub100 = Form ;
lincat Sub1000 = Form ; 
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Form = \two ->  
  {s = two ; size = pl} ;

lin num x = x ;
-- lin n1 mkNum "diha" ;
lin n2 = {s = "dua" ; size = two} ;
lin n3 = mkNum "tailu" ;
lin n4 = mkNum "patu" ;
lin n5 = mkNum "lima" ;
lin n6 = mkNum "nomu" ;
lin n7 = mkNum "pitu" ;
lin n8 = mkNum "walu" ;
lin n9 = mkNum "hiwa" ;

oper ss : Str -> {s : Str ; size : Size} = \s1 -> {s = s1 ; size = pl} ;

lin pot01 = {s = "diha" ; size = sg} ;
lin pot0 d = d ; 
lin pot110 = ss "hakambulu" ; 
lin pot111 = ss ("hakambulu" ++ "hau") ;
lin pot1to19 d = ss ("hakambulu" ++ (if12 d.size d.s)) ;
lin pot0as1 n = n ;
lin pot1 d = ss (d.s ++ "kambulu" ) ;
lin pot1plus d e = ss (d.s ++ "kambulu" ++ (if12 e.size e.s)) ;
lin pot1as2 n = n ;
lin pot2 d = ss (selsg d.size "hangahu" (d.s ++ "ngahu")) ;
lin pot2plus d e = ss (selsg d.size "hangahu" (d.s ++ "ngahu") ++ e.s) ;
lin pot2as3 n = {s = n.s };
lin pot3 n = {s = (selsg n.size "hariu" (n.s ++ "riu"))} ;
lin pot3plus n m = {s = (selsg n.size "hariu" (n.s ++ "riu")) ++ m.s } ;

oper if12 : Size -> Str -> Str = \sz -> \a ->
  table {sg => "hau" ; two => "dambu" ; _ => a} ! sz ; 
oper selsg : Size -> Str -> Str -> Str = \sz -> \a -> \b -> 
  table {sg => a ; _ => b} ! sz ; 

