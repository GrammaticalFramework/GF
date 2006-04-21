--# -path=.:prelude

concrete DatabaseEng of Database = open Prelude in {

-- english query language

flags lexer=literals ; unlexer=text ;

-- concrete syntax; greatly simplified - just for test purposes

lin 
  QueryS s = s ;
  QueryQ q = q ;

  PredA1 np a = prefixSS "is" (cc2 np a) ;

  WhichA1 n a = ss ("which" ++ n.s ++ "are" ++ a.s) ;
  WhichA2 n q a = ss ("which" ++ n.s ++ "are" ++ q.s ++ a.s) ;

  ComplA2     = cc2 ;

  Every A  = ss ("every" ++ A.s) ;
  Some A   = ss ("some" ++ A.s) ;
  UseInt n = n ;

  Number = ss "numbers" ;

  Even   = ss "even" ;
  Odd    = ss "odd" ;
  Prime  = ss "prime" ;
  Equal  = ss ("equal" ++ "to") ;
  Greater = ss ("greater" ++ "than") ;
  Smaller = ss ("smaller" ++ "than") ;
  Divisible = ss ("divisible" ++ "by") ;
 
-- replies

lin
  Yes = ss "yes" ;
  No = ss "no" ;

  None = ss "none" ;
  List xs = xs ;
  One n = n ;
  Cons = cc2 ;

-- general moves

lin 
  Quit = ss "quit" ;
  Bye = ss "bye" ;
}
