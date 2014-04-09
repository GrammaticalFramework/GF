--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppSpa of App = 

  TranslateSpa - [
  -- Verb
    ComplVS, ComplVQ, ComplVA,
    Slash2V3, Slash3V3, SlashV2V, SlashV2S, SlashV2Q, SlashV2A,
    SlashVV, SlashV2VNP,
    ReflVP,
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
    SelfAdvVP, SelfAdVVP, SelfNP,
  -- Construction
    hungry_VP, thirsty_VP, has_age_VP, have_name_Cl, married_Cl, what_name_QCl, how_old_QCl, how_far_QCl,
    weather_adjCl, is_right_VP, is_wrong_VP, n_units_AP, bottle_of_CN, cup_of_CN, glass_of_CN, 
    where_go_QCl, where_come_from_QCl, go_here_VP, come_here_VP, come_from_here_VP, go_there_VP, come_there_VP, come_from_there_VP,
  -- Extensions
    PassVPSlash, PassAgentVPSlash
  ]

  ,PhrasebookSpa - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, cheap_A,expensive_A, open_A, closed_A]

    ** open ParadigmsSpa, SyntaxSpa, Prelude in {

flags
  literal=Symb ;

-- to suppress punctuation
lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;
  GObjectPlease o = lin Text (mkUtt o) ;
  PhrasePhr p = {s = "+" ++ p.s} | p ;
  Phrase_Chunk p = p ;

}
