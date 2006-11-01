abstract Shallow = Lexicon, Grammar-[
  VP, 
  ImpersCl,  -- : VP -> Cl ;        -- it rains
  GenericCl, -- : VP -> Cl ;        -- one sleeps
  ProgrVP,   -- : VP -> VP ;        -- be sleeping
  ImpPl1,    -- : VP -> Utt ;       -- let's go
  UttVP,     -- : VP -> Utt ;                 -- to sleep
  QuestVP,   -- : IP -> VP -> QCl ;            -- who walks
  RelVP,     -- : RP -> VP -> RCl ;      -- who loves John
  PredVP,    -- : NP -> VP -> Cl ;         -- John walks
  PredSCVP,  -- : SC -> VP -> Cl ;         -- that you go makes me happy
  ImpVP,     -- : VP -> Imp ;              -- go
  EmbedVP,   -- : VP -> SC ;               -- to go
  UseV    ,  -- : V   -> VP ;              -- sleep
  ComplV2 ,  -- : V2  -> NP -> VP ;        -- use it
  ComplV3 ,  -- : V3  -> NP -> NP -> VP ;  -- send a message to her
  ComplVV ,  -- : VV  -> VP -> VP ;        -- want to run
  ComplVS ,  -- : VS  -> S  -> VP ;        -- know that she runs
  ComplVQ ,  -- : VQ  -> QS -> VP ;        -- ask if she runs
  ComplVA ,  -- : VA  -> AP -> VP ;        -- look red
  ComplV2A,  -- : V2A -> NP -> AP -> VP ;  -- paint the house red
  ReflV2  ,  -- : V2 -> VP ;               -- use itself
  UseComp ,  -- : Comp -> VP ;             -- be warm
  PassV2  ,  -- : V2 -> VP ;               -- be used
  AdvVP   ,  -- : VP -> Adv -> VP ;        -- sleep here
  AdVVP      -- : AdV -> VP -> VP ;        -- always sleep
  ]
** {

  cat 
    Advs ; 
    AdVs ;

  fun
    NoAdv : Advs ;
    NoAdV : AdVs ;
    ConAdv : Adv -> Advs -> Advs ;
    ConAdV : AdV -> AdVs -> AdVs ;

    PredUseV    : NP -> AdVs -> V -> Advs -> Cl ;
    PredComplV2 : NP -> AdVs -> V2 -> NP -> Advs -> Cl ;
    PredUseComp : NP -> AdVs -> Comp -> Advs -> Cl ;

    QuestUseV    : IP -> AdVs -> V -> Advs -> QCl ;
    QuestComplV2 : IP -> AdVs -> V2 -> NP -> Advs -> QCl ;
    QuestUseComp : IP -> AdVs -> Comp -> Advs -> QCl ;

}
