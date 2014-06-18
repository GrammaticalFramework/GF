--# -path=.:../../lib/src/chunk:../../lib/src/translator:../phrasebook/gfos

concrete AppIta of App = 

  TranslateIta - [
  -- Verb
    ComplVS, ComplVQ, ComplVA,
    Slash2V3, Slash3V3, SlashV2V, SlashV2S, SlashV2Q, SlashV2A,
    SlashVV, SlashV2VNP,
    PassVP, ReflVP,
    AdvVPSlash, AdVVPSlash, VPSlashPrep,
  -- Sentence
    PredSCVP, 
    AdvSlash, SlashPrep, SlashVS,
    EmbedS, EmbedQS, EmbedVP, RelS,
  -- Question
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP,
  -- Idiom
    CleftNP, CleftAdv,
    ExistIP,
    ExistNPAdv, ExistIPAdv,
    ImpP3,
    SelfAdvVP, SelfAdVVP, SelfNP
    
  -- Construction
  -- Extensions
  ]

  ,PhrasebookIta - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_A, closed_A]

    ** open ParadigmsIta, SyntaxIta, Prelude in {

flags
  literal=Symb ;

lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;
  GObjectPlease o = lin Text (mkUtt o) ;
  PhrasePhr p = {s = "+" ++ p.s} | p ;
  Phrase_Chunk p = p ;

}
