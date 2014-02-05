abstract Predication = {

flags 
  startcat = Utt ;

cat
  Arg ;
  V Arg ;
  VP Arg ;
  VPC Arg ;  -- conjunction of VP
  Ant ;
  Tense ;
  Pol ;
  Cl Arg ;
  ClC Arg ;  -- conjunction of Cl
  QCl Arg ;
  NP ;
  Adv Arg ;  -- preposition is Adv aNP
  S ;
  Utt ;
  AP Arg ;
  CN Arg ;   -- the country he became the president of
  IP ;
  Conj ;
  IAdv ;

fun
  aNone, aS, aV, aQ, aA, aN : Arg ;
  aNP : Arg -> Arg ;
  TPres, TPast, TFut, TCond : Tense ;
  PPos, PNeg : Pol ;
  ASimul, AAnter : Ant ;

  UseV           : Ant -> Tense -> Pol -> (a : Arg) -> V a       -> VP a ;
  PassUseV       : Ant -> Tense -> Pol -> (a : Arg) -> V (aNP a) -> VP a ;
  AgentPassUseV  : Ant -> Tense -> Pol -> (a : Arg) -> V (aNP a) -> NP -> VP a ;
  
  SlashV2   : (a : Arg) -> VP (aNP a)        -> NP    -> VP a ;         -- consuming first NP
  SlashV3   : (a : Arg) -> VP (aNP (aNP a))  -> NP    -> VP (aNP a) ;   -- consuming second NP
  ComplVS   : (a : Arg) -> VP aS             -> Cl  a -> VP a ;
  ComplVV   : (a : Arg) -> VP aV             -> VP  a -> VP a ;
  ComplVQ   : (a : Arg) -> VP aQ             -> QCl a -> VP a ;
  ComplVA   : (a : Arg) -> VP aA             -> AP  a -> VP a ;
  ComplVN   : (a : Arg) -> VP aN             -> CN  a -> VP a ;
  SlashV2S  : (a : Arg) -> VP (aNP aS)       -> Cl a  -> VP (aNP a) ;   -- a:Arg gives slash propagation, SlashVS
  SlashV2V  : (a : Arg) -> VP (aNP aV)       -> VP a  -> VP (aNP a) ;  
  SlashV2A  : (a : Arg) -> VP (aNP aA)       -> AP a  -> VP (aNP a) ;      
  SlashV2N  : (a : Arg) -> VP (aNP aN)       -> CN a  -> VP (aNP a) ;      
  SlashV2Q  : (a : Arg) -> VP (aNP aA)       -> QCl a -> VP (aNP a) ;      

  UseAP : Ant -> Tense -> Pol -> (a : Arg) -> AP a -> VP a ;

  PredVP : (a : Arg) -> NP -> VP a -> Cl a ;

  SlashClNP : (a : Arg) -> Cl (aNP a) -> NP -> Cl a ;      -- slash consumption: hon tittar på + oss

  ReflVP  : (a : Arg) -> VP (aNP a) -> VP a ;              -- refl on first position (direct object)
  ReflVP2 : (a : Arg) -> VP (aNP (aNP a)) -> VP (aNP a) ;  -- refl on second position (indirect object)

  QuestVP    : (a : Arg) -> IP   -> VP a         -> QCl a ; 
  QuestSlash : (a : Arg) -> IP   -> QCl (aNP a)  -> QCl a ;
  QuestCl    : (a : Arg)         -> Cl a         -> QCl a ;
  QuestIAdv  : (a : Arg) -> IAdv -> Cl a         -> QCl a ;

  UseCl  : Cl aNone  -> S ;
  UseQCl : QCl aNone -> S ; -- deprecate QS

  UseAdvCl : Adv aNone -> Cl aNone -> S ;  -- lift adv to front
  
  UttS  : S -> Utt ;

-- when to add adverbs

----  AdvVP  : Adv -> (a : Arg) -> VP a -> VP a ; ---- these create many ambiguities
  ---- "hon tvingar oss att sova idag": 196 parses, 13s. With AdvVP restricted to top level: 32 parses, 7s
  ---- with AdvCl, just 16 parses, 0.2 s

  AdvCl   : (a : Arg) -> Adv a -> Cl aNone  -> Cl a ; 

  AdvQCl  : (a : Arg) -> Adv a -> QCl aNone -> QCl a ; 


-- participles as adjectives

  PresPartAP      : (a : Arg) -> V a       -> AP a ;
  PastPartAP      : (a : Arg) -> V (aNP a) -> AP a ;
  AgentPastPartAP : (a : Arg) -> V (aNP a) -> NP -> AP a ;

-- VP coordination

  StartVPC : Conj -> (a : Arg) -> VP a -> VP a  -> VPC a ;
  ContVPC  :         (a : Arg) -> VP a -> VPC a -> VPC a ;
  UseVPC   : (a : Arg) -> VPC a -> VP a ;

-- clause coordination, including "she loves and we look at (her)"
  StartClC : Conj -> (a : Arg) -> Cl a -> Cl a  -> ClC a ;
  ContClC  :         (a : Arg) -> Cl a -> ClC a -> ClC a ;
  UseClC   : (a : Arg) -> ClC a -> Cl a ;

  ComplAdv : (a : Arg) -> Adv (aNP a) -> NP -> Adv a ; -- typically: formation of preposition phrase

--------------- from now on, to be inherited from standard RGL; here just for test purposes


-- lexicon

  sleep_V     : V aNone ;
  walk_V      : V aNone ;
  love_V2     : V (aNP aNone) ;
  look_V2     : V (aNP aNone) ;
  believe_VS  : V aS ;
  tell_V2S    : V (aNP aS) ;  
  prefer_V3   : V (aNP (aNP aNone)) ;
  want_VV     : V aV ;
  force_V2V   : V (aNP aV) ;
  promise_V2V : V (aNP aV) ;
  wonder_VQ   : V aQ ;
  become_VA   : V aA ;
  become_VN   : V aN ;
  make_V2A    : V (aNP aA) ;
  ask_V2Q     : V (aNP aQ) ;
  promote_V2N : V (aNP aN) ;

  old_A       : AP aNone ;
  married_A2  : AP (aNP aNone) ; -- married to her
  eager_AV    : AP aV ;          -- eager to sleep
  easy_A2V    : AP (aNP aV) ;    -- easy for him to sleep
  professor_N : CN aNone ;
  manager_N2  : CN (aNP aNone) ; -- manager of X

  she_NP : NP ;
  we_NP : NP ;

  today_Adv : Adv aNone ;
  always_AdV : Adv aNone ;
  who_IP : IP ;

  with_Prep : Adv (aNP aNone) ;
  and_Conj : Conj ;
  why_IAdv : IAdv ;

}