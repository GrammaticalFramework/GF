abstract Demonstrative = Categories ** {

  cat
    MS ;
    MQ ;
    Dem ;
    DAdv ;
    Point ;

  fun
    MkPoint : String -> Point ;

    DemV  : V  -> Dem -> DAdv -> MS ;
    DemV2 : V2 -> Dem -> Dem -> DAdv -> MS ;
    ModDemV  : VV -> V  -> Dem -> DAdv -> MS ;
    ModDemV2 : VV -> V2 -> Dem -> Dem -> DAdv -> MS ;

    QDemV    : V  -> IP -> DAdv -> MQ ;
    QDemV2   : V2 -> IP -> Dem -> DAdv -> MQ ;

    this_Dem    : Point -> Dem ;
    that_Dem    : Point -> Dem ;
    thisDet_Dem : Point -> CN -> Dem ;
    thatDet_Dem : Point -> CN -> Dem ;

    here_DAdv      : Point -> DAdv -> DAdv ;
    here7from_DAdv : Point -> DAdv -> DAdv ;
    here7to_DAdv   : Point -> DAdv -> DAdv ;
    NoDAdv         : DAdv ;

}
