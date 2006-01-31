incomplete concrete PredicationI of Predication = Cat ** open ParamX, Lang in {

flags optimize = all_subs ;

lincat
  AS = {s : Polarity => S} ;

lin
  PosAS as = as.s ! Pos ;
  NegAS as = as.s ! Neg ;

--2 Predication patterns.

  predV v x = mkAS x (UseV v) ;
  predV2 v x y = mkAS x (ComplV2 v y) ;
  predV3 v x y z = mkAS x (ComplV3 v y z) ;
  predVColl v x y = mkAS (ConjNP and_Conj (BaseNP x y)) (UseV v) ;
  predA a x = mkAS x (UseComp (CompAP (PositA a))) ;
  predA2 a x y = mkAS x (UseComp (CompAP (ComplA2 a y))) ;
  predAComp a x y = mkAS x (UseComp (CompAP (ComparA a y))) ;
  predAColl a x y = mkAS (ConjNP and_Conj (BaseNP x y)) (UseComp (CompAP (PositA a))) ;
  predN n x = mkAS x (UseComp (CompNP (DetCN (DetSg IndefSg NoOrd) (UseN n)))) ;
  predN2 n x y = mkAS x (UseComp (CompNP (DetCN (DetSg IndefSg NoOrd) (ComplN2 n y)))) ;
  predNColl n x y = mkAS (ConjNP and_Conj (BaseNP x y)) 
    (UseComp (CompNP (DetCN (DetPl IndefPl NoNum NoOrd) (UseN n)))) ;
  predAdv a x = mkAS x (UseComp (CompAdv a)) ;
  predPrep p x y = mkAS x (UseComp (CompAdv (PrepNP p y))) ;

--2 Individual-valued function applications

  appN2 n x = DetCN (DetSg DefSg NoOrd) (ComplN2 n x) ;
  appN3 n x y = DetCN (DetSg DefSg NoOrd) (ComplN2 (ComplN3 n x) y) ;
  appColl n x y = DetCN (DetSg DefSg NoOrd) (ComplN2 n (ConjNP and_Conj (BaseNP x y))) ;

--2 Families of types

-- These are expressed by relational nouns applied to arguments.

  famN2 n x = ComplN2 n x ;
  famN3 n x y = ComplN2 (ComplN3 n x) y ; 
  famColl n x y = ComplN2 n (ConjNP and_Conj (BaseNP x y)) ;

--2 Type constructor

-- This is similar to a family except that the argument is a type.

  typN2 f n = ComplN2 f (DetCN (DetPl IndefPl NoNum NoOrd) n) ;


oper
  mkAS : NP -> VP -> {s : Polarity => S} = \x,vp -> {
    s = table {
      Pos => UseCl TPres ASimul PPos (PredVP x vp) ;
      Neg => UseCl TPres ASimul PNeg (PredVP x vp)
      }
    } ; 

}
