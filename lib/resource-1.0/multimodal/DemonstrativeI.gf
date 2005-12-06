incomplete concrete DemonstrativeI of Demonstrative = Cat, TenseX **
  open Prelude, Test, Structural, ParamX, DemRes in {

  lincat

    MS     = Dem {s : Polarity => Str} ;
    MQS    = Dem {s : Polarity => Str} ;
    MImp   = Dem {s : Polarity => Str} ;
    MVP    = Dem VP ;
    MComp  = Dem Comp ;
    MAP    = Dem AP ;
    DNP    = Dem NP ;
    DAdv   = Dem Adv ;
    Point  = DemRes.Point ;

  lin

    MkPoint s = mkPoint s.s ;

    PredMVP np vp = 
      let cl = PredVP np vp
      in 
      mkDem 
        {s : Polarity => Str} 
        (polCases (PosCl cl).s (NegCl cl).s) (concatPoint np vp) ;

    DemV verb      = mkDem VP (UseV verb) noPoint ;
    DemV2 verb obj = mkDem VP (ComplV2 verb obj) obj ;
    DemVV vv vp    = mkDem VP (ComplVV vv vp) vp ;

    DemComp comp = mkDem VP (UseComp comp) comp ;
---    DemComp = keepDem VP UseComp ;

    DCompAP ap   = mkDem Comp (CompAP ap) ap ;
    DCompAdv adv = mkDem Comp (CompAdv adv) adv ;
     

    AdvMVP vp adv =
      mkDem VP (AdvVP vp adv) (concatPoint vp adv) ;

    this_DNP = mkDem NP this_NP ;
    that_DNP = mkDem NP that_NP ;

    thisDet_DNP cn = 
      mkDem NP (DetCN (MkDet NoPredet this_Quant NoNum NoOrd) cn) ;
    thatDet_DNP cn = 
      mkDem NP (DetCN (MkDet NoPredet that_Quant NoNum NoOrd) cn) ;

    here_DAdv      = mkDem Adv here_Adv ;
    here7from_DAdv = mkDem Adv here7from_Adv ;
    here7to_DAdv   = mkDem Adv here7to_Adv ;

    PrepDNP p np   = mkDem Adv (PrepNP p np) np ;

    DemNP np = nonDem NP (np ** {lock_NP = <>}) ;
--    DemAdv = nonDem Adv ;
    PhrMS pol ms = {s = pol.s ++ ms.s ! pol.p ++ ";" ++ ms.point} ;


    point1 = mkPoint "p1" ;
    point2 = mkPoint "p2" ;

}

