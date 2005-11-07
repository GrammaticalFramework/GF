abstract Demonstrative = Categories ** {

  cat
    MS ;    -- multimodal sentence or question
    MQS ;   -- multimodal wh question
    MImp ;  -- multimodal imperative
    DNP ;   -- demonstrative noun phrase
    DAdv ;  -- demonstrative adverbial
    Point ; -- pointing gesture

  fun
    MkPoint : String -> Point ;

    DemV     : V  -> DNP -> DAdv -> MS ;              -- this flies (here)
    DemV2    : V2 -> DNP -> DNP -> DAdv -> MS ;       -- this takes that
    ModDemV  : VV -> V  -> DNP -> DAdv -> MS ;        -- this wants to fly
    ModDemV2 : VV -> V2 -> DNP -> DNP -> DAdv -> MS ; -- this wants to take that

    ImpDemV     : V  -> DAdv -> MImp ;                -- fly (here)
    ImpDemV2    : V2 -> DNP -> DAdv -> MImp ;         -- take that

    QDemV       : V  -> IP -> DAdv -> MQS ;            -- who flies (here)  
    QDemV2      : V2 -> IP -> DNP -> DAdv -> MQS ;     -- who takes that
    QDemSlashV2 : V2 -> DNP -> IP -> DAdv -> MQS ;     -- whom does that take
    QModDemV       : VV -> V  -> IP -> DAdv -> MQS ;        -- who wants to fly (here)  
    QModDemV2      : VV -> V2 -> IP -> DNP -> DAdv -> MQS ; -- who wants to take that
    QModDemSlashV2 : VV -> V2 -> DNP -> IP -> DAdv -> MQS ; -- whom does that want to take

    this_DNP    : Point -> DNP ;        -- this
    that_DNP    : Point -> DNP ;        -- that
    thisDet_DNP : Point -> CN -> DNP ;  -- this car
    thatDet_DNP : Point -> CN -> DNP ;  -- that car

    here_DAdv      : Point -> DAdv -> DAdv ; -- here
    here7from_DAdv : Point -> DAdv -> DAdv ; -- from here
    here7to_DAdv   : Point -> DAdv -> DAdv ; -- to here
    NoDAdv         : DAdv ;

}
