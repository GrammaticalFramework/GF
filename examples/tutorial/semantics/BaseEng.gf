--# -path=.:prelude

concrete BaseEng of Base = open Prelude in {

flags lexer=literals ; unlexer=text ;

-- English concrete syntax; greatly simplified - just for demo purposes

lin 
  PredAP  = infixSS "is" ;

  ComplA2 = cc2 ;

  ModCN   = cc2 ;

  ConjS  c = infixSS c.s ;
  ConjAP c = infixSS c.s ;
  ConjNP c = infixSS c.s ;

  Every = prefixSS "every" ;
  Some  = prefixSS "some" ;

  And = ss "and" ;
  Or  = ss "or" ;

  UseInt n = n ;

  Number = ss "number" ;

  Even   = ss "even" ;
  Odd    = ss "odd" ;
  Prime  = ss "prime" ;
  Equal  = ss ("equal" ++ "to") ;
  Greater = ss ("greater" ++ "than") ;
  Smaller = ss ("smaller" ++ "than") ;
  Divisible = ss ("divisible" ++ "by") ;
 
}
