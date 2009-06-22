incomplete concrete PredicationI of Predication = 
  Cat ** open ParamX, Lang, Syntax in {

flags optimize = all_subs ;

lin
  PosCl cl = mkS cl ;
  NegCl cl = mkS PNeg cl ;

--2 Predication patterns.

  predV v x = PredVP x (UseV v) ; -- mkCl x v ;
  predV2 v x y = mkCl x v y ;
  predV3 v x y z = mkCl x v y z ;
  predVColl v x y = mkCl (mkNP and_Conj x y) v ;
  predA a x = mkCl x a ;
  predA2 a x y = mkCl x a y ; 
  predAComp a x y = mkCl x a y ;
  predAColl a x y = mkCl (mkNP and_Conj x y) a ;
  predN n x = mkCl x (mkNP IndefArt (mkCN n)) ; --- Sg/Pl ?
  predN2 n x y = mkCl x (mkNP IndefArt (ComplN2 n y)) ; --- Sg/Pl ?
  predNColl n x y = mkCl (mkNP and_Conj x y) (mkNP IndefArt (mkCN n)) ;
  predAdv a x = mkCl x a ;
  predPrep p x y = mkCl x (mkAdv p y) ; 

--2 Imperatives and infinitives.

  impV2 v x = mkPhr (mkImp v x) ;
  infV2 v x = mkPhr (mkUtt (mkVP v x)) ; 

--2 Individual-valued function applications

  appN2 n x = mkNP DefArt (mkCN n x) ;
  appN3 n x y = mkNP DefArt (mkCN n x y) ;
  appColl n x y = mkNP DefArt (mkCN n (mkNP and_Conj x y)) ;

--2 Families of types

-- These are expressed by relational nouns applied to arguments.

  famN2 n x = ComplN2 n x ;
  famN3 n x y = ComplN2 (ComplN3 n x) y ; 
  famColl n x y = ComplN2 n (ConjNP and_Conj (BaseNP x y)) ;

--2 Type constructor

-- This is similar to a family except that the argument is a type.

  typN2 f n = ComplN2 f (DetArtPl DefArt n) ;

}
