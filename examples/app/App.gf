abstract App = 
  Translate - [
  -- Verb
    SlashV2V, 
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

}
