abstract Predication = {

flags 
  startcat = Utt ;

cat
  Arg ;
  V Arg ;
  VP Arg ;
  Temp ;
  Pol ;
  Cl Arg ;
  NP ;
  Adv ;
  AdV ;
  S ;
  QS ;
  Utt ;
  AP Arg ;
  IP ;
  Prep ;

fun
  aNone, aS, aV : Arg ;
  aNP : Arg -> Arg ;
  TPres, TPast : Temp ;
  PPos, PNeg : Pol ;

  UseV : Temp -> Pol -> (a : Arg) -> V a -> VP a ;
  
  SlashVNP  : (a : Arg) -> VP (aNP a)        -> NP   -> VP a ;         -- consuming first NP
  SlashVNP2 : (a : Arg) -> VP (aNP (aNP a))  -> NP   -> VP (aNP a) ;   -- consuming second NP
  ComplVS   : (a : Arg) -> VP aS             -> Cl a -> VP a ;
  ComplVV   : (a : Arg) -> VP aV             -> VP a -> VP a ;
  SlashV2S  : (a : Arg) -> VP (aNP aS)       -> Cl a -> VP (aNP a) ;   -- a:Arg gives slash propagation, SlashVS
  SlashV2V  : (a : Arg) -> VP (aNP aV)       -> VP a -> VP (aNP a) ;      

  UseAP : Temp -> Pol -> (a : Arg) -> AP a -> VP a ;

  PredVP : (a : Arg) -> NP -> VP a -> Cl a ;

  PrepCl : Prep -> (a : Arg) -> Cl a -> Cl (aNP a) ;

  AdvVP  : Adv -> (a : Arg) -> VP a -> VP a ;
  AdVVP  : AdV -> (a : Arg) -> VP a -> VP a ;

  ReflVP  : (a : Arg) -> VP (aNP a) -> VP a ;              -- refl on first position (direct object)
  ReflVP2 : (a : Arg) -> VP (aNP (aNP a)) -> VP (aNP a) ;  -- refl on second position (indirect object)

  QuestVP    : IP -> VP aNone       -> QS ; ---- TODO: QS a
  QuestSlash : IP -> Cl (aNP aNone) -> QS ;

  DeclCl  : Cl aNone -> S ;
  QuestCl : Cl aNone -> QS ;
  
  UttS  : S -> Utt ;
  UttQS : QS -> Utt ;

  sleep_V    : V aNone ;
  love_V2    : V (aNP aNone) ;
  believe_VS : V aS ;
  tell_V2S   : V (aNP aS) ;  
  prefer_V3  : V (aNP (aNP aNone)) ;
  want_VV    : V aV ;
  force_V2V  : V (aNP aV) ;

  old_A      : AP aNone ;
  married_A2 : AP (aNP aNone) ; -- married to her
  eager_AV   : AP aV ;          -- eager to sleep
  easy_A2V   : AP (aNP aV) ;    -- easy for him to sleep

  she_NP : NP ;
  we_NP : NP ;

  today_Adv : Adv ;
  always_AdV : AdV ;
  who_IP : IP ;

  PrepNP : Prep -> NP -> Adv ;

  with_Prep : Prep ;

}