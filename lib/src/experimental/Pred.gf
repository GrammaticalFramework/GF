abstract Pred = Cat [Ant,NP,Utt,IP,IAdv,Conj] ** {

cat
  Arg ;
  PrV Arg ;
  PrVP Arg ;
  VPC Arg ;  -- conjunction of VP
  Tense ;
  Pol ;
  PrCl Arg ;
  ClC Arg ;  -- conjunction of Cl
  PrQCl Arg ;
  PrAdv Arg ;
  PrS ;
  PrAP Arg ;
  PrCN Arg ; -- the country he became the president of

fun
  aNone, aS, aV, aQ, aA, aN : Arg ;
  aNP : Arg -> Arg ;
  TPres, TPast, TFut, TCond : Tense ;
  PPos, PNeg : Pol ;
  ASimul, AAnter : Ant ;

  UseV           : Ant -> Tense -> Pol -> (a : Arg) -> PrV a       -> PrVP a ;
  PassUseV       : Ant -> Tense -> Pol -> (a : Arg) -> PrV (aNP a) -> PrVP a ;
  AgentPassUseV  : Ant -> Tense -> Pol -> (a : Arg) -> PrV (aNP a) -> NP -> PrVP a ;
  
  SlashV2   : (a : Arg) -> PrVP (aNP a)        -> NP    -> PrVP a ;         -- consuming first NP
  SlashV3   : (a : Arg) -> PrVP (aNP (aNP a))  -> NP    -> PrVP (aNP a) ;   -- consuming second NP
  ComplVS   : (a : Arg) -> PrVP aS             -> PrCl  a -> PrVP a ;
  ComplVV   : (a : Arg) -> PrVP aV             -> PrVP  a -> PrVP a ;
  ComplVQ   : (a : Arg) -> PrVP aQ             -> PrQCl a -> PrVP a ;
  ComplVA   : (a : Arg) -> PrVP aA             -> PrAP  a -> PrVP a ;
  ComplVN   : (a : Arg) -> PrVP aN             -> PrCN  a -> PrVP a ;
  SlashV2S  : (a : Arg) -> PrVP (aNP aS)       -> PrCl a  -> PrVP (aNP a) ;   -- a:Arg gives slash propagation, SlashVS
  SlashV2V  : (a : Arg) -> PrVP (aNP aV)       -> PrVP a  -> PrVP (aNP a) ;  
  SlashV2A  : (a : Arg) -> PrVP (aNP aA)       -> PrAP a  -> PrVP (aNP a) ;      
  SlashV2N  : (a : Arg) -> PrVP (aNP aN)       -> PrCN a  -> PrVP (aNP a) ;      
  SlashV2Q  : (a : Arg) -> PrVP (aNP aA)       -> PrQCl a -> PrVP (aNP a) ;      

  UseAP : Ant -> Tense -> Pol -> (a : Arg) -> PrAP a -> PrVP a ;

  PredVP : (a : Arg) -> NP -> PrVP a -> PrCl a ;

  SlashClNP : (a : Arg) -> PrCl (aNP a) -> NP -> PrCl a ;    -- slash consumption: hon tittar på + oss

  ReflVP  : (a : Arg) -> PrVP (aNP a) -> PrVP a ;              -- refl on first position (direct object)
  ReflVP2 : (a : Arg) -> PrVP (aNP (aNP a)) -> PrVP (aNP a) ;  -- refl on second position (indirect object)

  QuestVP    : (a : Arg) -> IP   -> PrVP a         -> PrQCl a ; 
  QuestSlash : (a : Arg) -> IP   -> PrQCl (aNP a)  -> PrQCl a ;
  QuestCl    : (a : Arg)         -> PrCl a         -> PrQCl a ;
  QuestIAdv  : (a : Arg) -> IAdv -> PrCl a         -> PrQCl a ;

  UseCl  : PrCl aNone  -> PrS ;
  UseQCl : PrQCl aNone -> PrS ; -- deprecate QS

  UseAdvCl : PrAdv aNone -> PrCl aNone -> PrS ;  -- lift adv to front
  
  UttS  : PrS -> Utt ;

  AdvCl   : (a : Arg) -> PrAdv a -> PrCl aNone  -> PrCl a ; 

  AdvQCl  : (a : Arg) -> PrAdv a -> PrQCl aNone -> PrQCl a ; 

-- participles as adjectives

  PresPartAP      : (a : Arg) -> PrV a       -> PrAP a ;
  PastPartAP      : (a : Arg) -> PrV (aNP a) -> PrAP a ;
  AgentPastPartAP : (a : Arg) -> PrV (aNP a) -> NP -> PrAP a ;

-- PrVP coordination

  StartVPC : Conj -> (a : Arg) -> PrVP a -> PrVP a  -> VPC a ;
  ContVPC  :         (a : Arg) -> PrVP a -> VPC a -> VPC a ;
  UseVPC   : (a : Arg) -> VPC a -> PrVP a ;

-- clause coordination, including "she loves and we look at (her)"
  StartClC : Conj -> (a : Arg) -> PrCl a -> PrCl a  -> ClC a ;
  ContClC  :         (a : Arg) -> PrCl a -> ClC a -> ClC a ;
  UseClC   : (a : Arg) -> ClC a -> PrCl a ;

  ComplAdv : (a : Arg) -> PrAdv (aNP a) -> NP -> PrAdv a ; -- typically: formation of preposition phrase

}