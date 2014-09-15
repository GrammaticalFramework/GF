--# -path=.:../../lib/src/chunk:../../lib/src/finnish/stemmed:../../lib/src/finnish:../../lib/src/api:../../lib/src/translator:../phrasebook/gfos:alltenses

concrete AppFin of App = 

  TranslateFin - [
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

  ,PhrasebookFin - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_A, open_Adv]

    ** open ParadigmsFin, SyntaxFin, Prelude in {

flags
  literal=Symb ;

lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;
  GObjectPlease o = lin Text (mkUtt o) ;

  PhrasePhr p = {s = "+" ++ p.s} | p ;
  Phrase_Chunk p = p ;


ComplV2V v np vp = mkVP v np vp ;
ComplV2A v np vp = mkVP v np vp ;
ComplV2Q v np vp = mkVP v np vp ;
ComplV2S v np vp = mkVP v np vp ;
ComplV3  v np vp = mkVP v np vp ;

}
