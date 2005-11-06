--# -path=.:../abstract:../../prelude

incomplete concrete DemonstrativeI of Demonstrative = 
  open Prelude, Resource, Basic, DemRes in {

  lincat
    MS = MultiSentence ;
    MQ = MultiQuestion ;
    Dem = Demonstrative ;
    DAdv = DemAdverb ;
    Point = Pointing ;

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

    QDemV verb ip adv = 
      mkDemQ (QPredV ip verb) adv noPointing ;
    QDemV2 verb ip ob adv = 
      mkDemQ (QPredV2 ip verb ob) adv ob ;


    this_Dem  p = this_NP ** p ;
    that_Dem  p = this_NP ** p ;
    thisDet_Dem p cn = DetNP this_Det cn ** p ;
    thatDet_Dem p cn = DetNP that_Det cn ** p ;

    here_DAdv p = addDAdv here_Adv p ;
    here7from_DAdv p = addDAdv here7from_Adv p ;
    here7to_DAdv p = addDAdv here7to_Adv p ;

    NoDAdv = {s,s5 = [] ; lock_Adv = <>} ;

}
