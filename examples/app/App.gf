abstract App = 
  Translate - [
  -- Verb
    SlashV2V,             -- replaced by more efficient inlined versions
    Slash2V3, Slash3V3, SlashV2S, SlashV2Q, SlashV2A, 
    SlashVV, SlashV2VNP,
    AdvVPSlash, AdVVPSlash, VPSlashPrep,
  -- Sentence
    PredSCVP, 
    AdvSlash, SlashPrep, SlashVS,
    EmbedS, EmbedQS, EmbedVP, RelS,
  -- Question
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP,
  -- Idiom
    CleftNP, CleftAdv,
    ImpP3    
  -- Construction
  -- Extensions
  ]
  ,Phrasebook

              ** {
flags
  startcat=Phr ;
  heuristic_search_factor=0.80; -- doesn't seem to affect speed or quality much

fun
  PhrasePhr : Phrase -> Phr ;
  Phrase_Chunk : Phrase -> Chunk ;

  ComplV2V : V2V -> NP -> VP -> VP ;
  ComplV2A : V2A -> NP -> AP -> VP ;
  ComplV2Q : V2Q -> NP -> QS -> VP ;
  ComplV2S : V2S -> NP -> S  -> VP ;
  ComplV3  : V3  -> NP -> NP -> VP ;

}
