-- abstract syntax of a query language

abstract Base = {

cat
  S ; 
  NP ; 
  PN ;
  CN ; 
  AP ; 
  A2 ; 
  Conj ;
fun 

-- sentence syntax
  PredAP  : NP -> AP -> S ;

  ComplA2 : A2 -> NP -> AP ;

  ModCN   : AP -> CN -> CN ;

  ConjAP  : Conj -> AP -> AP -> AP ;
  ConjNP  : Conj -> NP -> NP -> NP ;

  UsePN   : PN -> NP ;
  Every   : CN -> NP ;
  Some    : CN -> NP ;

  And, Or : Conj ;  

-- lexicon

  UseInt  : Int -> PN ;

  Number : CN ;
  Even, Odd, Prime : AP ;
  Equal, Greater, Smaller, Divisible  : A2 ;

  Sum, Product, GCD : ListPN -> PN ;

-- adding questions

cat
  Question ;
  Answer ;
  ListPN ;
fun
  WhatIs   : PN -> Question ;
  WhichAre : CN -> AP -> Question ;
  QuestS   : S -> Question ;

  Yes   : Answer ;
  No    : Answer ;
  Value : NP -> Answer ;

  None  : NP ;
  Many  : ListPN -> NP ;
  BasePN : PN -> PN -> ListPN ;
  ConsPN : PN -> ListPN -> ListPN ; 
}
