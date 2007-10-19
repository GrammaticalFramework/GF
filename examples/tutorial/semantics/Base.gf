-- abstract syntax of a query language

abstract Base = {

cat
  S ; 
  NP ; 
  CN ; 
  AP ; 
  A2 ; 
  Conj ;
fun 
  PredAP  : NP -> AP -> S ;

  ComplA2 : A2 -> NP -> AP ;

  ModCN   : AP -> CN -> CN ;

  ConjS   : Conj -> S -> S -> S ;
  ConjAP  : Conj -> AP -> AP -> AP ;
  ConjNP  : Conj -> NP -> NP -> NP ;

  Every   : CN -> NP ;
  Some    : CN -> NP ;

  And, Or : Conj ;  

-- lexicon

  UseInt  : Int -> NP ;

  Number : CN ;
  Even, Odd, Prime : AP ;
  Equal, Greater, Smaller, Divisible  : A2 ;

}

