incomplete concrete ShallowI of Shallow = Grammar-[
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
** open Grammar, Prelude in {

  lincat 
    Advs = Adv ; 
    AdVs = AdV ;

  lin
    NoAdv = {s = [] ; lock_Adv = <>} ;
    NoAdV = {s = [] ; lock_AdV = <>} ;
    ConAdv a as = {s = a.s ++ as.s ; lock_Adv = <>} ;
    ConAdV a as = {s = a.s ++ as.s ; lock_AdV = <>} ;

    PredUseV np adVs v advs = 
      PredVP np (AdvVP (AdVVP adVs (UseV v)) advs) ;
    PredComplV2 np adVs v ob = 
      PredVP np (AdVVP adVs (ComplV2 v ob)) ;
    PredComplVS np adVs v ob = 
      PredVP np (AdVVP adVs (ComplVS v ob)) ;
    PredUseComp np adVs v advs = 
      PredVP np (AdvVP (AdVVP adVs (UseComp v)) advs) ;

    PredComplVV_V np adVs vv v advs = 
      PredVP np (AdvVP (AdVVP adVs (ComplVV vv (UseV v))) advs) ;
    PredComplVV_V2 np adVs vv v2 ob = 
      PredVP np (AdVVP adVs (ComplVV vv (ComplV2 v2 ob))) ;
    PredComplVV_Comp np adVs vv v advs = 
      PredVP np (AdvVP (AdVVP adVs (ComplVV vv (UseComp v))) advs) ;

    QuestUseV np adVs v advs = 
      QuestVP np (AdvVP (AdVVP adVs (UseV v)) advs) ;
    QuestComplV2 np adVs v ob = 
      QuestVP np (AdVVP adVs (ComplV2 v ob)) ;
    QuestComplVS np adVs v ob = 
      QuestVP np (AdVVP adVs (ComplVS v ob)) ;
    QuestUseComp np adVs v advs = 
      QuestVP np (AdvVP (AdVVP adVs (UseComp v)) advs) ;

    QuestComplVV_V np adVs vv v advs = 
      QuestVP np (AdvVP (AdVVP adVs (ComplVV vv (UseV v))) advs) ;
    QuestComplVV_V2 np adVs vv v2 ob = 
      QuestVP np (AdVVP adVs (ComplVV vv (ComplV2 v2 ob))) ;
    QuestComplVV_Comp np adVs vv v advs = 
      QuestVP np (AdvVP (AdVVP adVs (ComplVV vv (UseComp v))) advs) ;

}
