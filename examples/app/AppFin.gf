--# -path=.:../../lib/src/chunk:../../lib/src/finnish/stemmed:../../lib/src/finnish:../../lib/src/api:../../lib/src/translator:../phrasebook/gfos:alltenses

concrete AppFin of App = 

  TranslateFin - [
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
  ],
   PhrasebookFin - [open_Adv,closed_A,open_A,at_Prep]
   

   ** AppFunctor with (Syntax = SyntaxFin) ;
