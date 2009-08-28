interface Syntax = Grammar - 
    [UseCl,PredVP,ComplV2,UseV,DetCN,ModCN,CompAP,AdAP,
     UseN,UseA,Pres,Perf,Pos,Neg] **
  open Grammar in {

oper
  mkS = overload {
    mkS : Cl -> S = UseCl Pres Pos ;
    mkS : Tense -> Cl -> S = \t -> UseCl t Pos ;
    mkS : Pol -> Cl -> S = UseCl Pres ;
    mkS : Tense -> Pol -> Cl -> S = UseCl ;
    } ;

  mkCl = overload {
    mkCl : NP -> V  -> Cl = \np,v -> PredVP np (UseV v) ;
    mkCl : NP -> V2 -> NP -> Cl = \np,v,o -> PredVP np (ComplV2 v o) ;
    mkCl : NP -> A  -> Cl = \np,a -> PredVP np (CompAP (UseA a)) ;
    mkCl : NP -> AP -> Cl = \np,ap -> PredVP np (CompAP ap) ;
    mkCl : NP -> VP -> Cl = PredVP ;
    } ;

  mkAP = overload {
    mkAP : A -> AP = UseA ;
    mkAP : AdA -> AP -> AP = AdAP ;
    } ;

  mkNP = overload {
    mkNP : Det -> N -> NP = \d,n -> DetCN d (UseN n) ;
    mkNP : Det -> CN -> NP = \d,n -> DetCN d n ;
    } ;

  mkCN = overload {
    mkCN : N  -> CN = UseN ;
    mkCN : A  -> N  -> CN = \a,n -> ModCN (UseA a) (UseN n) ; 
    mkCN : A  -> CN -> CN = \a,n -> ModCN (UseA a) n ; 
    mkCN : AP -> N  -> CN = \a,n -> ModCN a (UseN n) ; 
    mkCN : AP -> CN -> CN = \a,n -> ModCN a n ; 
    } ;

  presTense : Tense = Pres ;
  perfTense : Tense = Perf ;
  posPol : Pol = Pos ;
  negPol : Pol = Neg ;

}
