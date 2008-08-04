concrete sango of Numerals = {
-- include numerals.Abs.gf ;

param Size = sg | pl | over10;

oper Form = {s : Str ; size : Size } ;

lincat Numeral = {s : Str} ;
lincat Digit = Form ;
lincat Sub10 = Form ;
lincat Sub100 = Form ;
lincat Sub1000 = Form ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO: Encoding

oper mkNum : Str -> Form = \mbili -> 
  {s = mbili ; size = pl };

-- O IPA for o in cod
-- Ó

-- lin n1 = mkNum "ÓkO" ; 
lin n2 = mkNum "óse" ;
lin n3 = mkNum "otá" ;
lin n4 = mkNum "osió" ;
lin n5 = mkNum "ukú" ;
lin n6 = mkNum "omaná" ;
lin n7 = mkNum "mbásámbárá" ;
lin n8 = mkNum "miombe" ;
lin n9 = mkNum "ngombáyá" ;

oper nandoni : Str = ("na" ++ variants {"ndó" ++ "ní" ; []}) ;

oper ss : Str -> Form = \s1 -> {s = s1 ; size = over10} ;

lin pot01 = {s = "ÓkO" ; size = sg };
lin pot0 d = d ;
lin pot110 = ss ("bale" ++ "ÓkO"); 
lin pot111 = ss ("bale" ++ "ÓkO" ++ nandoni ++ "ÓkO");
lin pot1to19 d = ss ("bale" ++ "ÓkO" ++ nandoni ++ d.s);
lin pot0as1 n = n ;
lin pot1 d = ss ("bale" ++ d.s ) ;
lin pot1plus d e = ss ("bale" ++ d.s ++ nandoni ++ e.s ) ; 
lin pot1as2 n = n ;
lin pot2 d = ss (mkng d.size d.s) ;
lin pot2plus d e = ss ((mkng d.size d.s) ++ nandoni ++ e.s) ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = mktau n.size n.s } ;
lin pot3plus n m = {s = mktau n.size (n.s ++ nandoni ++ m.s) } ; 

oper mkng : Size -> Str -> Str = \sz -> \attr -> 
  table {pl => "ngbangbu" ++ attr ;
         over10 => "dummy" ;  
         sg => variants {"ngbangbu" ++ "ÓkO"; "ngbangbu" }} ! sz ;

oper mktau : Size -> Str -> Str = \sz -> \attr ->
  table {pl => "ngbangbu" ++ "bale" ++ attr ;
         over10 => "N/A" ; 
         sg => variants {"ngbangbu" ++ "bale"; "kutu"} ++ attr} ! sz ;





}
