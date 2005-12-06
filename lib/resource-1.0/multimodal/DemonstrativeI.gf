incomplete concrete DemonstrativeI of Demonstrative = Cat, TenseX **
  open Prelude, Test, Structural, ParamX, DemRes in {

  lincat

    MS     = Dem {s : Polarity => Str} ;
    MQS    = Dem {s : Polarity => Str} ;
    MImp   = Dem {s : Polarity => Str} ;
    MVP    = Dem VP ;
    MComp  = Dem Comp ;
    MAP    = Dem AP ;
    MNP    = Dem NP ;
    MAdv   = Dem Adv ;

    Point = DemRes.Point ;

  lin

    MkPoint s = mkPoint s.s ;

    MPredVP np vp = 
      let cl = PredVP np vp
      in 
      mkDem 
        {s : Polarity => Str} 
        (polCases (PosCl cl).s (NegCl cl).s) (concatPoint np vp) ;

    MQPredVP np vp = 
      let cl = QuestCl (PredVP np vp)
      in 
      mkDem 
        {s : Polarity => Str} 
        (polCases 
           ((PosQCl cl).s ! QDir) 
           ((NegQCl cl).s ! QDir))
        (concatPoint np vp) ;

    MQuestVP np vp = 
      let cl = QuestVP np vp
      in 
      mkDem 
        {s : Polarity => Str} 
        (polCases 
           ((PosQCl cl).s ! QDir) 
           ((NegQCl cl).s ! QDir))
        vp ;

    MImpVP vp =
      let imp = ImpVP vp
      in
      mkDem 
        {s : Polarity => Str} 
        (polCases 
           ((UttImpSg PPos imp).s) 
           ((UttImpSg PNeg imp).s))
        vp ;
      

    MUseV verb        = mkDem VP (UseV verb) noPoint ;
    MComplV2 verb obj = mkDem VP (ComplV2 verb obj) obj ;
    MComplVV vv vp    = mkDem VP (ComplVV vv vp) vp ;

    MUseComp comp = mkDem VP (UseComp comp) comp ;

    MCompAP ap   = mkDem Comp (CompAP ap) ap ;
    MCompAdv adv = mkDem Comp (CompAdv adv) adv ;
    MCompNP np   = mkDem Comp (CompNP np) np ;

    MPositA a  = mkDem AP (PositA a) noPoint ;
    MComparA a np = mkDem AP (ComparA a np) np ;
    

    MAdvVP vp adv =
      mkDem VP (AdvVP vp adv) (concatPoint vp adv) ;

    this_MNP = mkDem NP this_NP ;
    that_MNP = mkDem NP that_NP ;

    thisDet_MNP cn = 
      mkDem NP (DetCN (MkDet NoPredet this_Quant NoNum NoOrd) cn) ;
    thatDet_MNP cn = 
      mkDem NP (DetCN (MkDet NoPredet that_Quant NoNum NoOrd) cn) ;

    here_MAdv      = mkDem Adv here_Adv ;
    here7from_MAdv = mkDem Adv here7from_Adv ;
    here7to_MAdv   = mkDem Adv here7to_Adv ;

    MPrepNP p np   = mkDem Adv (PrepNP p np) np ;

    DemNP np = nonDem NP (np ** {lock_NP = <>}) ;
    DemAdv adv = nonDem Adv (adv ** {lock_Adv = <>}) ;

    PhrMS pol ms   = {s = pol.s ++ ms.s ! pol.p ++ ";" ++ ms.point} ;
    PhrMQS pol ms  = {s = pol.s ++ ms.s ! pol.p ++ ";" ++ ms.point} ;
    PhrMImp pol ms = {s = pol.s ++ ms.s ! pol.p ++ ";" ++ ms.point} ;

    point1 = mkPoint "p1" ;
    point2 = mkPoint "p2" ;

}

