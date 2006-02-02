incomplete concrete PredicationI of Predication = Cat ** open ParamX, Lang in {

flags optimize = all_subs ;

lin
  PosCl cl = UseCl TPres ASimul PPos cl ;
  NegCl cl = UseCl TPres ASimul PNeg cl ;

--2 Predication patterns.

  predV v x = PredVP x (UseV v) ;
  predV2 v x y = PredVP x (ComplV2 v y) ;
  predV3 v x y z = PredVP x (ComplV3 v y z) ;
  predVColl v x y = PredVP (ConjNP and_Conj (BaseNP x y)) (UseV v) ;
  predA a x = PredVP x (UseComp (CompAP (PositA a))) ;
  predA2 a x y = PredVP x (UseComp (CompAP (ComplA2 a y))) ;
  predAComp a x y = PredVP x (UseComp (CompAP (ComparA a y))) ;
  predAColl a x y = 
    PredVP (ConjNP and_Conj (BaseNP x y)) (UseComp (CompAP (PositA a))) ;
  predN n x = 
    PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN n)))) ;
  predN2 n x y = 
    PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (ComplN2 n y)))) ;
  predNColl n x y = PredVP (ConjNP and_Conj (BaseNP x y)) 
    (UseComp (CompNP (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) (UseN n)))) ;
  predAdv a x = PredVP x (UseComp (CompAdv a)) ;
  predPrep p x y = PredVP x (UseComp (CompAdv (PrepNP p y))) ;

--2 Individual-valued function applications

  appN2 n x = DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 n x) ;
  appN3 n x y = DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 (ComplN3 n x) y) ;
  appColl n x y = 
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 n (ConjNP and_Conj (BaseNP x y))) ;

--2 Families of types

-- These are expressed by relational nouns applied to arguments.

  famN2 n x = ComplN2 n x ;
  famN3 n x y = ComplN2 (ComplN3 n x) y ; 
  famColl n x y = ComplN2 n (ConjNP and_Conj (BaseNP x y)) ;

--2 Type constructor

-- This is similar to a family except that the argument is a type.

  typN2 f n = ComplN2 f (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) n) ;

}
