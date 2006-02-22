abstract Demonstrative = Cat, PredefAbs ** {

-- Naming convention: $M$ prepended to 'unimodal' names.
-- Exceptions: lexical units, those without unimodal counterparts.

  cat

    MS ;     -- multimodal sentence or question
    MQS ;    -- multimodal wh question
    MImp ;   -- multimodal imperative
    MVP ;    -- multimodal verb phrase
    MComp ;  -- multimodal complement to copula (MAP, MNP, MAdv)
    MAP ;    -- multimodal adjectival phrase
    MNP ;    -- multimodal (demonstrative) noun phrase
    MAdv ;   -- multimodal (demonstrative) adverbial

    Point ;  -- pointing gesture

  fun

-- A pointing gesture is constructed from a string.

    MkPoint : String -> Point ;

-- Construction of sentences, questions, and imperatives.

    MPredVP   : MNP -> MVP -> MS ;    -- he flies here
    MQPredVP  : MNP -> MVP -> MQS ;   -- does he fly here

    MQuestVP  : IP  -> MVP -> MQS ;   -- who flies here

    MImpVP    : MVP -> MImp ;         -- fly here!

-- Construction of verb phrases from verb + complements.

    MUseV    : V  -> MVP ;            -- flies (here)
    MComplV2 : V2 -> MNP -> MVP ;     -- takes this (here)
    MComplVV : VV -> MVP -> MVP ;     -- wants to fly (here)

    MUseComp : MComp -> MVP ;         -- is here ; is bigger than this

    MCompAP  : MAP  -> MComp ;        -- bigger than this
    MCompNP  : MNP  -> MComp ;        -- the price of this
    MCompAdv : MAdv -> MComp ;        -- here

    MPositA  : A -> MAP ;             -- big
    MComparA : A -> MNP -> MAP ;      -- bigger than this

-- Adverbial modification of a verb phrase.

    MAdvVP : MVP -> MAdv -> MVP ;     -- fly here

-- Demonstrative pronouns as NPs and determiners.

    this_MNP    : Point -> MNP ;        -- this
    that_MNP    : Point -> MNP ;        -- that
    thisDet_MNP : CN -> Point -> MNP ;  -- this car
    thatDet_MNP : CN -> Point -> MNP ;  -- that car

-- Demonstrative adverbs.

    here_MAdv      : Point -> MAdv ;    -- here
    here7from_MAdv : Point -> MAdv ;    -- from here
    here7to_MAdv   : Point -> MAdv ;    -- to here

-- Building an adverb as prepositional phrase.

    MPrepNP : Prep -> MNP -> MAdv ;     -- in this car

-- Using ordinary categories.

-- Mounting nondemonstrative expressions.

    DemNP   : NP  -> MNP ;
    DemAdv  : Adv -> MAdv ;

-- Top-level phrases.

    PhrMS   : Pol -> MS   -> Phr ;
    PhrMS   : Pol -> MS   -> Phr ;
    PhrMQS  : Pol -> MQS  -> Phr ;
    PhrMImp : Pol -> MImp -> Phr ;

-- For testing and example-based grammar writing.

    point1, point2 : Point ;

}
