-- abstract syntax of a small arithmetic query language

abstract Database = {

cat 
  Query ; S ; Q ; NP ; CN ; PN ; A1 ; A2 ;

fun 
  QueryS : S -> Query ; 
  QueryQ : Q -> Query ;

  PredA1  : NP -> A1 -> S ;

  WhichA1 : CN -> A1 -> Q ;
  WhichA2 : CN -> NP -> A2 -> Q ;

  ComplA2 : A2 -> NP -> A1 ;
  UseInt  : Int -> NP ;

  Every   : CN -> NP ;
  Some    : CN -> NP ;

-- lexicon

  Number : CN ;
  Even,Odd,Prime : A1 ;
  Equal,Greater,Smaller,Divisible  : A2 ;

-- replies

cat Answer ; ListInt ;

fun
  Yes,No : Answer ;
  None : Answer ;
  List : ListInt -> Answer ;
  One : Int -> ListInt ;
  Cons : Int -> ListInt -> ListInt ;

-- general moves
fun
  Quit : Query ;
  Bye : Answer ;

}
