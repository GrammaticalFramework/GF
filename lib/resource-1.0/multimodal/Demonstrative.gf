abstract Demonstrative = Cat, Tense ** {

  cat

    MS ;     -- multimodal sentence or question
    MQS ;    -- multimodal wh question
    MImp ;   -- multimodal imperative
    MVP ;    -- multimodal verb phrase
    DNP ;    -- demonstrative noun phrase
    DAdv ;   -- demonstrative adverbial
    Point ;  -- pointing gesture

  fun

-- A pointing gesture is constructed from a string.

    MkPoint : String -> Point ;

-- Construction of sentences, questions, and imperatives.

    PredMVP   : DNP -> MVP -> MS ;  -- he flies here
    QuestMVP  : DNP -> MVP -> MQS ; -- does he fly here

    QQuestMVP : IP  -> MVP -> MQS ; -- who flies here

    ImpMVP    : MVP -> MImp ;       -- fly here!

-- Construction of verb phrases from verb + complements.

    DemV   : V  -> MVP ;              -- flies (here)
    DemV2  : V2 -> DNP -> MVP ;       -- takes this (here)
    DemVV  : VV -> MVP -> MVP ;       -- wants to fly (here)

    DemComp : DComp -> MVP ;          -- is here ; is bigger than this

    DCompAP  : DAP  -> DComp ;        -- bigger than this
    DCompNP  : DNP  -> DComp ;        -- the price of this
    DCompAdv : DAdv -> DComp ;        -- here


-- Adverbial modification of a verb phrase.

    AdvMVP : MVP -> DAdv -> MVP ;      

-- Demonstrative pronouns as NPs and determiners.

    this_DNP    : Point -> DNP ;        -- this
    that_DNP    : Point -> DNP ;        -- that
    thisDet_DNP : CN -> Point -> DNP ;  -- this car
    thatDet_DNP : CN -> Point -> DNP ;  -- that car

-- Demonstrative adverbs.

    here_DAdv      : Point -> DAdv ;    -- here
    here7from_DAdv : Point -> DAdv ;    -- from here
    here7to_DAdv   : Point -> DAdv ;    -- to here

-- Building an adverb as prepositional phrase.

    PrepDNP : Prep -> DNP -> DAdv ;

-- Using ordinary categories.

-- Interface to $Demonstrative$.

    DemNP   : NP  -> DNP ;
    DemAdv  : Adv -> DAdv ;
    PhrMS   : Pol -> MS   -> Phr ;
    PhrMS   : Pol -> MS   -> Phr ;
    PhrMQS  : Pol -> MQS  -> Phr ;
    PhrMImp : Pol -> MImp -> Phr ;

-- For testing and example-based grammar writing.

    point1, point2 : Point ;

}
