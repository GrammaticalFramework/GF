--# -path=.:prelude

concrete BaseEng of Base = open Prelude in {

flags lexer=literals ; unlexer=text ;

-- English concrete syntax; greatly simplified - just for demo purposes

lin 
  PredAP  = infixSS "is" ;

  ComplA2 = cc2 ;

  ModCN   = cc2 ;

  ConjAP c = infixSS c.s ;
  ConjNP c = infixSS c.s ;

  UsePN a = a ;
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
 
  Sum     = prefixSS ["the sum of"] ;
  Product = prefixSS ["the product of"] ;
  GCD     = prefixSS ["the greatest common divisor of"] ;

  WhatIs = prefixSS ["what is"] ;
  WhichAre cn ap = ss ("which" ++ cn.s ++ "is" ++ ap.s) ; ---- are
  QuestS s = s ; ---- inversion

  Yes = ss "yes" ;
  No = ss "no" ;

  Value np = np ;
  None = ss "none" ;
  Many list = list ;

  BasePN = infixSS "and" ;
  ConsPN = infixSS "," ;
  
}
