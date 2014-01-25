abstract Predication = {

flags 
  startcat = Utt ;

cat
  Arg ;
  V Arg ;
  VP Arg ;
  VPC Arg ;  -- conjunction of VP
  Temp ;
  Pol ;
  Cl Arg ;
  QCl Arg ;
  NP ;
  Adv ;
  AdV ;
  S ;
  Utt ;
  AP Arg ;
  IP ;
  Prep ;
  Conj ;

fun
  aNone, aS, aV, aQ, aA : Arg ;
  aNP : Arg -> Arg ;
  TPres, TPast : Temp ;
  PPos, PNeg : Pol ;

  UseV : Temp -> Pol -> (a : Arg) -> V a -> VP a ;
  
  SlashVNP  : (a : Arg) -> VP (aNP a)        -> NP    -> VP a ;         -- consuming first NP
  SlashVNP2 : (a : Arg) -> VP (aNP (aNP a))  -> NP    -> VP (aNP a) ;   -- consuming second NP
  ComplVS   : (a : Arg) -> VP aS             -> Cl  a -> VP a ;
  ComplVV   : (a : Arg) -> VP aV             -> VP  a -> VP a ;
  ComplVQ   : (a : Arg) -> VP aQ             -> QCl a -> VP a ;
  ComplVA   : (a : Arg) -> VP aA             -> AP  a -> VP a ;
  SlashV2S  : (a : Arg) -> VP (aNP aS)       -> Cl a  -> VP (aNP a) ;   -- a:Arg gives slash propagation, SlashVS
  SlashV2V  : (a : Arg) -> VP (aNP aV)       -> VP a  -> VP (aNP a) ;  
  SlashV2A  : (a : Arg) -> VP (aNP aA)       -> AP a  -> VP (aNP a) ;      
  SlashV2Q  : (a : Arg) -> VP (aNP aA)       -> QCl a -> VP (aNP a) ;      

  UseAP : Temp -> Pol -> (a : Arg) -> AP a -> VP a ;

  PredVP : (a : Arg) -> NP -> VP a -> Cl a ;

  PrepCl : Prep -> (a : Arg) -> Cl a -> Cl (aNP a) ;

  AdvVP  : Adv -> (a : Arg) -> VP a -> VP a ;
  AdVVP  : AdV -> (a : Arg) -> VP a -> VP a ;

  ReflVP  : (a : Arg) -> VP (aNP a) -> VP a ;              -- refl on first position (direct object)
  ReflVP2 : (a : Arg) -> VP (aNP (aNP a)) -> VP (aNP a) ;  -- refl on second position (indirect object)

  QuestVP    : (a : Arg) -> IP -> VP a         -> QCl a ; 
  QuestSlash : (a : Arg) -> IP -> QCl (aNP a)  -> QCl a ;
  QuestCl    : (a : Arg)       -> Cl a         -> QCl a ;

  UseCl  : Cl aNone  -> S ;
  UseQCl : QCl aNone -> S ; -- deprecate QS
  
  UttS  : S -> Utt ;

  StartVPC : Conj -> (a : Arg) -> VP a -> VP a  -> VPC a ;
  ContVPC  :         (a : Arg) -> VP a -> VPC a -> VPC a ;
  UseVPC   : (a : Arg) -> VPC a -> VP a ;

-- lexicon

  sleep_V    : V aNone ;
  walk_V     : V aNone ;
  love_V2    : V (aNP aNone) ;
  look_V2    : V (aNP aNone) ;
  believe_VS : V aS ;
  tell_V2S   : V (aNP aS) ;  
  prefer_V3  : V (aNP (aNP aNone)) ;
  want_VV    : V aV ;
  force_V2V  : V (aNP aV) ;
  promise_V2V  : V (aNP aV) ;
  wonder_VQ  : V aQ ;
  become_VA  : V aA ;
  make_V2A   : V (aNP aA) ;
  ask_V2Q    : V (aNP aQ) ;

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

  and_Conj : Conj ;

}