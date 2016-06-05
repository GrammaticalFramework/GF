incomplete concrete AppFunctor of App = 

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

   ** open Syntax in {

flags
  literal=Symb ;

lin
  ComplV2 v np = mkVP v np ;

  ComplV2V v np vp = mkVP v np vp ;
--  ComplV2A v np vp = mkVP v np vp ;
--  ComplV2Q v np vp = mkVP v np vp ;
--  ComplV2S v np vp = mkVP v np vp ;
  ComplV3  v np vp = mkVP v np vp ;



  PassV2 v2 = passiveVP v2 ;
  PassAgentV2 v2 np = mkVP (passiveVP v2) (mkAdv by8agent_Prep np) ;
  RelV2 rp np v2 = mkRCl rp (mkClSlash np (mkVPSlash v2)) ;
  QuestV2 ip np v2 = mkQCl ip (mkClSlash np (mkVPSlash v2)) ;

}
