interface Syntax = open Prelude, Grammar in {

oper
  mkPhr = overload {
    mkPhr : S -> Phr 
      = PhrS ;
    mkPhr : QS -> Phr 
      = PhrQS ;
  } ;

  mkS = overload {
    mkS : Pol -> NP -> VP -> S
       = \p,np,vp -> UseCl p (PredVP np vp) ;
    mkS : NP -> VP -> S
       = \np,vp -> UseCl PPos (PredVP np vp) ;
    mkS : Pol -> NP -> V2 -> NP -> S
       = \p,np,v,o -> UseCl p (PredVP np (ComplV2 v o)) ;
    mkS : NP -> V2 -> NP -> S
       = \np,v,o -> UseCl PPos (PredVP np (ComplV2 v o)) ;
    mkS : Pol -> NP -> AP -> S
       = \p,np,ap -> UseCl p (PredVP np (ComplAP ap)) ;
    mkS : NP -> AP -> S
       = \np,ap -> UseCl PPos (PredVP np (ComplAP ap)) ;
    } ;

  mkNP : Det -> CN -> NP 
    = DetCN ;

  mkCN = overload {
    mkCN : AP -> CN -> CN 
      = ModCN ;
    mkCN : N -> CN 
      = UseN ;
  } ;

  mkAP = overload {
    mkAP : AdA -> AP -> AP 
      = AdAP ;
    mkAP : A -> AP 
      = UseA ;
  } ;

}
