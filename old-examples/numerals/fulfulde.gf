include numerals.Abs.gf ;
 
param Size = sg | pl | two;

oper Form = {s : Str ; size : Size } ; 

lincat Numeral = {s : Str} ;
lincat Digit = Form ;
lincat Sub10 = Form ;
lincat Sub100 = Form ;
lincat Sub1000 = Form ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ; -- TODO: Encoding

oper mkNum = ss ;

oper ss : Str -> Form = \f -> {s = f ; size = pl } ;

-- lin n1 = mkNum "go'o" ; 
lin n2 = {s = "d.id.i" ; size = two } ;
lin n3 = mkNum "tati" ;
lin n4 = mkNum "nai" ;
lin n5 = mkNum "jowi" ;
lin n6 = mkNum "jowe:go" ; 
lin n7 = mkNum "jowe:d.id.i" ;
lin n8 = mkNum "jowe:tati" ;
lin n9 = mkNum "jowe:nai" ;

lin pot01 = {s = "go'o" ; size = sg };
lin pot0 d = d ;
lin pot110 = ss "sappo" ;
lin pot111 = ss ("sappo" ++ "e" ++ "go'o") ;
lin pot1to19 d = ss ("sappo" ++ "e" ++ d.s) ;
lin pot0as1 n = n ;
lin pot1 d = ss (mkten d.size d.s) ;
lin pot1plus d e = ss ((mkten d.size d.s) ++ "e" ++ e.s) ;
lin pot1as2 n = n ;
lin pot2 d = ss (mkhund d.size d.s) ;
lin pot2plus d e = ss ((mkhund d.size d.s) ++ "e" ++ e.s) ;
lin pot2as3 n = n ;
lin pot3 n = ss (mkthou n.size n.s) ; 
lin pot3plus n m = ss ((mkthou n.size n.s) ++ m.s) ;

oper mkten : Size -> Str -> Str = \sz -> \attr -> 
  table {two => "no:gas" ; _ => "chappand.e" ++ attr } ! sz ;
oper mkhund : Size -> Str -> Str = \sz -> \attr -> 
  table {sg => "temerre" ; _ => "temed.d.e" ++ attr} ! sz ;
oper mkthou : Size -> Str -> Str = \sz -> \attr ->
  table {sg => "ujine:re"; _ => variants {"ujine" ++ attr ; "ujine:je" ++ attr}} ! sz ;
