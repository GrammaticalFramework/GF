-- predication library, built on resource grammar. AR 2002--2003

-- Users of the library should *not* look into this file, but only into
-- $predication.Types.gf$.

resource PredicationRus = open ResourceRus in {

-- We first define a set of predication patterns.

oper
  predV1 : V -> NP -> S ;             -- one-place verb: "John walks"
  predV2 : TV -> NP -> NP -> S ;      -- two-place verb: "John loves Mary"
  predVColl : V -> NP -> NP -> S ;    -- collective verb: "John and Mary fight"
  predA1 : Adj1 -> NP -> S ;          -- one-place adjective: "John is old"
  predA2 : Adj2 -> NP -> NP -> S ;    -- two-place adj: "John is married to Mary"
  predAComp : AdjDeg -> NP -> NP -> S ; -- compar adj: "John is older than Mary"
  predAColl : Adj1 -> NP -> NP -> S ; -- collective adj: "John and Mary are married"
  predN1 : N -> NP -> S ;             -- one-place noun: "John is a man"
  predN2 : Fun -> NP -> NP -> S ;     -- two-place noun: "John is a lover of Mary"
  predNColl : N -> NP -> NP -> S ;    -- collective noun: "John and Mary are lovers"

-- Individual-valued function applications.

  appFun1 : Fun -> NP -> NP ;          -- one-place function: "the successor of x"
  appFunColl : Fun -> NP -> NP -> NP ; -- collective function: "the sum of x and y"

-- Families of types, expressed by common nouns depending on arguments.

  appFam1 : Fun -> NP -> CN ;          -- one-place family: "divisor of x"
  appFamColl : Fun -> NP -> NP -> CN ; -- collective family: "path between x and y"

-- Type constructor, similar to a family except that the argument is a type.

  constrTyp1 : Fun -> CN -> CN ;

-- Logical connectives on two sentences.

  conjS : S -> S -> S ;
  disjS : S -> S -> S ;
  implS : S -> S -> S ;

-- As an auxiliary, we need two-place conjunction of names ("John and Mary"), 
-- used in collective predication.

  conjNP : NP -> NP -> NP ;


-----------------------------
oper

  predV1 = \F, x -> PredVP x (PosVG (PredV F)) ;
  predV2 = \F, x, y -> PredVP x (PosVG (PredTV F y)) ;
  predVColl = \F, x, y -> PredVP (conjNP x y) (PosVG (PredV F)) ;
  predA1 = \F, x -> PredVP x (PosVG (PredAP (AdjP1 F))) ;
  predA2 = \F, x, y -> PredVP x (PosVG (PredAP (ComplAdj F y))) ;
  predAComp = \F, x, y -> PredVP x (PosVG (PredAP (ComparAdjP F y))) ;
  predAColl = \F, x, y -> PredVP (conjNP x y) (PosVG (PredAP (AdjP1 F))) ;
  predN1 = \F, x -> PredVP x (PosVG (PredCN (UseN F))) ;
  predN2 = \F, x, y -> PredVP x (PosVG (PredCN (AppFun F y))) ;
  predNColl = \F, x, y -> PredVP (conjNP x y) (PosVG (PredCN (UseN F))) ;

  appFun1 = \f, x -> DefOneNP (AppFun f x) ;
  appFunColl = \f, x, y -> DefOneNP (AppFun f (conjNP x y)) ;

  appFam1 = \F, x -> AppFun F x ;
  appFamColl = \F, x, y -> AppFun F (conjNP x y) ;

  conjS = \A, B -> ConjS AndConj (TwoS A B) ;
  disjS = \A, B -> ConjS OrConj (TwoS A B) ;
  implS = \A, B -> SubjS IfSubj A B ;

  constrTyp1 = \F, A -> AppFun F (IndefOneNP A) ;

  conjNP = \x, y -> ConjNP AndConj (TwoNP x y) ;

};
