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

fun aggreg : S -> S ;
def 
  aggreg (ConjS c (Pred Q F) B) = aggrAux c Q F B ;
  aggreg (ConjS c A          B) = ConjS c (aggreg A) (aggreg B) ;
  aggreg A = A ;

-- this auxiliary makes pattern matching on NP to test equality

fun aggrAux : Conj -> NP -> VP -> S -> S ;
def 
  -- aggregate verbs with shared subject
  aggrAux c John F    (Pred John G)    = Pred John (ConjVP c F G) ;
  aggrAux c Mary F    (Pred Mary G)    = Pred Mary (ConjVP c F G) ;
  aggrAux c Bill F    (Pred Bill G)    = Pred Bill (ConjVP c F G) ;

  -- aggregate subjects with shared verbs
  aggrAux c Q    Run  (Pred R    Run)  = Pred (ConjNP c Q R) Run ;
  aggrAux c Q    Walk (Pred R    Walk) = Pred (ConjNP c Q R) Walk ;
  aggrAux c Q    Swim (Pred R    Swim) = Pred (ConjNP c Q R) Swim ;

  -- this case takes care of munching
  aggrAux c Q    F    (ConjS e A B) = aggrAux c Q F (aggreg (ConjS e A B)) ;

  aggrAux c Q    F    B            = ConjS c (Pred Q F) (aggreg B) ;

-- unfortunately we cannot test string equality for Name : String -> NP ;
-- It would also be tedious to test the equality of complex
-- NPs and VPs, but not impossible.

-- have to add these, otherwise constants are not constructor patterns!

data NP = John | Mary | Bill ;
data VP = Run | Walk | Swim ;
}
