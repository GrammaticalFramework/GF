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
       = PredVP ;
    mkS : NP -> VP -> S
       = PredVP PPos ;
    mkS : Pol -> NP -> V2 -> NP -> S
       = \p,np,v,o -> PredVP p np (ComplV2 v o) ;
    mkS : NP -> V2 -> NP -> S
       = \np,v,o -> PredVP PPos np (ComplV2 v o) ;
    mkS : Pol -> NP -> AP -> S
       = \p,np,ap -> PredVP p np (ComplAP ap) ;
    mkS : NP -> AP -> S
       = \np,ap -> PredVP PPos np (ComplAP ap) ;
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
