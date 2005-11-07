--# -path=.:../abstract:../../prelude

incomplete concrete DemonstrativeI of Demonstrative = 
  open Prelude, Resource, Basic, DemRes in {

  lincat
    MS     = MultiSentence ;
    MQS    = MultiQuestion ;
    MImp   = MultiImperative ;
    DNP    = Demonstrative ;
    DAdv   = DemAdverb ;
    [DAdv] = DemAdverb ;
    Point  = Pointing ;

  lin
    MkPoint s = {s5 = s.s} ;

    DemV verb dem adv = 
      mkDemS (SPredV dem verb) adv dem ;
    DemV2 verb su ob adv = 
      mkDemS (SPredV2 su verb ob) adv (concatDem su ob) ;
    ModDemV vv verb dem adv = 
      mkDemS (SPredVV dem vv (UseVCl PPos ASimul (IPredV verb))) adv dem ;
    ModDemV2 vv verb su ob adv = 
      mkDemS (SPredVV su vv (UseVCl PPos ASimul (IPredV2 verb ob))) adv (concatDem su ob) ;

    ImpDemV verb adv = 
      mkDemImp (IPredV verb) adv noPointing ;
    ImpDemV2 verb ob adv = 
      mkDemImp (IPredV2 verb ob) adv ob ;

    QDemV verb ip adv = 
      mkDemQ (QPredV ip verb) adv noPointing ;
    QDemV2 verb ip ob adv = 
      mkDemQ (QPredV2 ip verb ob) adv ob ;
    QDemSlashV2 verb su ip adv = 
      mkDemQ (IntSlash ip (SlashV2 su verb)) adv su ;
    QModDemV vv verb ip adv = 
      mkDemQ (QPredVV ip vv (UseVCl PPos ASimul (IPredV verb))) adv noPointing ;
    QModDemV2 vv verb ip ob adv = 
      mkDemQ (QPredVV ip vv (UseVCl PPos ASimul (IPredV2 verb ob))) adv ob ;
    QModDemSlashV2 vv verb su ip adv = 
      mkDemQ (IntSlash ip (SlashVV2 su vv verb)) adv su ;

    this_DNP  p = this_NP ** p ;
    that_DNP  p = that_NP ** p ;
    thisDet_DNP p cn = DetNP this_Det cn ** p ;
    thatDet_DNP p cn = DetNP that_Det cn ** p ;

    here_DAdv p = mkDAdv here_Adv p ;
    here7from_DAdv p = mkDAdv here7from_Adv p ;
    here7to_DAdv p = mkDAdv here7to_Adv p ;

    BaseDAdv = {s,s5 = [] ; lock_Adv = <>} ;
    ConsDAdv a as = {s = a.s ++ as.s ; s5 = a.s5 ++ as.s5 ; lock_Adv = <>} ;

    PrepDNP p np = mkDAdv (AdvPP (PrepNP p np)) np ;

    point1 = {s5 = "p1"} ;
    point2 = {s5 = "p2"} ;

}
