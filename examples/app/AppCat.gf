--# -path=.:../../lib/src/chunk:../../lib/src/translator:../phrasebook/gfos


concrete AppCat of App = 

  TranslateCat - [
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

  ,PhrasebookCat - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, cheap_A,expensive_A, open_A, closed_A]

    ** open ParadigmsCat, SyntaxCat, Prelude in {

flags
  literal=Symb ;

-- to suppress punctuation
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


ComplV2 v np = mkVP v np ;

  PassV2 v2 = passiveVP v2 ;
  PassV2 v2 = passiveVP v2 ;
}
