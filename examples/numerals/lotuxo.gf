concrete lotuxo of Numerals = {
-- include numerals.Abs.gf ;

param Size = sg | pl ;

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
  {s = mbili; size = pl };

-- N [ng]
-- E epsilon
-- I i without dot
-- O IPA for o in cod

-- lin n1 = mkNum "âbotye" ; 
lin n2 = mkNum "ârrexai" ;
lin n3 = mkNum "xunixoi" ;
lin n4 = mkNum "aNwan" ;
lin n5 = mkNum "miet" ;
lin n6 = mkNum "IllE" ;
lin n7 = mkNum "xattarIk" ;
lin n8 = mkNum "xottoxunik" ;
lin n9 = mkNum "xOttONwan" ;

oper xo : Str = pre {"xO" ; 
                     "xo" / strs {"m" ; "xu" ; "xo"} ; 
                     "x'" / strs {"â" ; "a"}} ;

oper ss : Str -> Form = \s1 -> {s = s1 ; size = pl} ;

lin pot01  =
  {s = "âbotye" ; size = sg };
lin pot0 d = d ;
lin pot110 = ss "'tOmOn" ; 
lin pot111 = ss ("'tOmOn" ++ xo ++ "âbotye") ; 
lin pot1to19 d = ss ("'tOmOn" ++ xo ++ d.s ) ;
lin pot0as1 n = n ;
lin pot1 d = ss ("atOmwana" ++ d.s ) ;
lin pot1plus d e = ss ("atOmwana" ++ d.s ++ xo ++ e.s ) ; 
lin pot1as2 n = n ;
lin pot2 d = ss (mkessixa d.size d.s) ;
lin pot2plus d e = ss ((mkessixa d.size d.s) ++ "ikO" ++ e.s) ;
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = mktau n.size n.s } ;
lin pot3plus n m = {s = (mktau n.size n.s) ++ "ikO" ++ m.s} ;

oper mkessixa : Size -> Str -> Str = \sz -> \attr -> 
  table {pl => "EssIxa" ++ attr ; 
         sg => variants {"EssIxa" ++ "âbotye"; "atOmwana" ++ "'tOmOn"}} ! sz ;
oper mktau : Size -> Str -> Str = \sz -> \attr ->
  table {pl => "tausand" ++ attr ; 
         sg => variants {"tausand" ++ "âbotye"; "EssIxa" ++ "'tOmOn"}} ! sz ;

}
