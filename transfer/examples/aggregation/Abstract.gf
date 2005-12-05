-- testing transfer: aggregation by def definitions. AR 12/4/2003 -- 9/10

--   p "Mary runs or John runs and John walks" | l -transfer=Aggregation
--   Mary runs or John runs and walks
--   Mary or John runs and John walks

-- The two results are due to ambiguity in parsing. Thus it is not spurious!

abstract Abstract = {

cat 
  S ; NP ; VP ; Conj ;

fun
  Pred : NP -> VP -> S ;
  ConjS : Conj -> S -> S -> S ;
  ConjVP : Conj -> VP -> VP -> VP ;
  ConjNP : Conj -> NP -> NP -> NP ;

  John, Mary, Bill : NP ;
  Walk, Run, Swim : VP ;
  And, Or : Conj ;

}
