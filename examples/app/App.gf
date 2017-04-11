

abstract App = 
  Translate - [
  -- Verb
    SlashV2a,ComplSlash, -- replaced by a more efficient inlined version
    SlashV2V,             
    Slash2V3, Slash3V3, SlashV2S, SlashV2Q, SlashV2A, 
    SlashVV, SlashV2VNP,
    AdvVPSlash, AdVVPSlash, VPSlashPrep,
  -- Sentence
    SlashVP, SlashVS,
    PredSCVP, 
    AdvSlash, SlashPrep, SlashVS,
    EmbedS, EmbedQS, EmbedVP, RelS,
  -- Question
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP,
  -- Idiom
    CleftNP, CleftAdv,
    ImpP3,
  -- Construction
  -- Extensions
    PassVPSlash, PassAgentVPSlash -- not reachable anyway
  ]
  ,Phrasebook

              ** {
flags
  startcat=Phr ;
  heuristic_search_factor=0.80; -- doesn't seem to affect speed or quality much

fun
  PhrasePhr : Phrase -> Phr ;
  Phrase_Chunk : Phrase -> Chunk ;

  ComplV2 : V2 -> NP -> VP ;  -- sees him
  
  ComplV2V : V2V -> NP -> VP -> VP ;  -- forces him to leave
--  ComplV2A : V2A -> NP -> AP -> VP ;
--  ComplV2Q : V2Q -> NP -> QS -> VP ;
--  ComplV2S : V2S -> NP -> S  -> VP ;
  ComplV3  : V3  -> NP -> NP -> VP ;  -- gives him an apple

  PassV2       : V2 -> VP ;  -- is seen
  PassAgentV2  : V2 -> NP -> VP ;  -- is seen by her
  RelV2        : RP -> NP -> V2 -> RCl ; -- that she sees
  QuestV2      : IP -> NP -> V2 -> QCl ; -- whom does she see

}
