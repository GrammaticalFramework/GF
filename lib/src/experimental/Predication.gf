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
  S ;
  QS ;
  Utt ;
  AP Arg ;
  IP ;

fun
  aNone, aS, aV : Arg ;
  aNP : Arg -> Arg ;
  TPres, TPast : Temp ;
  PPos, PNeg : Pol ;

  UseV : Temp -> Pol -> (a : Arg) -> V a -> VP a ;
  
  SlashVNP  : (a : Arg) -> VP (aNP a)               -> NP -> VP a ;         -- consuming first NP
  SlashVNP2 : (a : Arg) -> VP (aNP (aNP a))         -> NP -> VP (aNP a) ;   -- consuming second NP
  ComplVS   :              VP aS       -> S         -> VP aNone ;
  ComplVV   :              VP aV       -> VP aNone  -> VP aNone ;
  SlashV2S  :              VP (aNP aS) -> S         -> VP (aNP aNone) ;
  SlashV2V  :              VP (aNP aV) -> VP aNone  -> VP (aNP aNone) ;

  UseAP : Temp -> Pol -> (a : Arg) -> AP a -> VP a ;

  PredVP : (a : Arg) -> NP -> VP a -> Cl a ;

  AdvVP  : Adv -> (a : Arg) -> VP a -> VP a ;

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

  who_IP : IP ;

}