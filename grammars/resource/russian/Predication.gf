-- predication library, built on resource grammar. AR 2002--2003

-- Users of the library should *not* look into this file, but only into
-- $predication.Types.gf$.

resource Predication = open Russian in {


oper
  predV1 = \F, x -> PredVP x (PosV F) ;
  predV2 = \F, x, y -> PredVP x (PosTV F y) ;
  predVColl = \F, x, y -> PredVP (conjNP x y) (PosV F) ;
  predA1 = \F, x -> PredVP x (PosA F) ;
  predA2 = \F, x, y -> PredVP x (PosA (ComplAdj F y)) ;
  predAComp = \F, x, y -> PredVP x (PosA (ComparAdjP F y)) ;
  predAColl = \F, x, y -> PredVP (conjNP x y) (PosA F) ;
  predN1 = \F, x -> PredVP x (PosCN (UseN F)) ;
  predN2 = \F, x, y -> PredVP x (PosCN (AppFun F y)) ;
  predNColl = \F, x, y -> PredVP (conjNP x y) (PosCN (UseN F)) ;

  appFun1 = \f, x -> DefOneNP (AppFun f x) ;
  appFunColl = \f, x, y -> DefOneNP (AppFun f (conjNP x y)) ;

  appFam1 = \F, x -> AppFun F x ;
  appFamColl = \F, x, y -> AppFun F (conjNP x y) ;

  conjS = \A, B -> ConjS AndConj (TwoS A B) ;
  disjS = \A, B -> ConjS OrConj (TwoS A B) ;
  implS = \A, B -> SubjS IfSubj A B ;

  constrTyp1 = \F, A -> AppFun F (IndefManyNP A) ;

  conjNP = \x, y -> ConjNP AndConj (TwoNP x y) ;

};
