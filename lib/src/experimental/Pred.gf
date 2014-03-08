abstract Pred = Cat [Ant,NP,Utt,IP,IAdv,Conj,RS,RP,Subj] ** {

cat
  Arg ;
  PrV Arg ;
  PrVP Arg ;
  PrVPI Arg ;
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

  UseV           : (a : Arg) -> Ant -> Tense -> Pol -> PrV a       -> PrVP a ;
  PassUseV       : (a : Arg) -> Ant -> Tense -> Pol -> PrV (aNP a) -> PrVP a ;
  AgentPassUseV  : (a : Arg) -> Ant -> Tense -> Pol -> PrV (aNP a) -> NP -> PrVP a ;

  ComplV2   : (a : Arg) -> PrVP (aNP a)        -> NP      -> PrVP a ;         -- she loves him
  ComplVS   : (a : Arg) -> PrVP aS             -> PrCl  a -> PrVP a ;         -- she says that I am here
  ComplVV   : (a : Arg) -> PrVP aV             -> PrVPI a -> PrVP a ;         -- she wants to sleep
  ComplVQ   : (a : Arg) -> PrVP aQ             -> PrQCl a -> PrVP a ;         -- she wonders who is here
  ComplVA   : (a : Arg) -> PrVP aA             -> PrAP  a -> PrVP a ;         -- she becomes old
  ComplVN   : (a : Arg) -> PrVP aN             -> PrCN  a -> PrVP a ;         -- she becomes a professor
  SlashV3   : (a : Arg) -> PrVP (aNP (aNP a))  -> NP      -> PrVP (aNP a) ;   -- she shows X to him
  SlashV2S  : (a : Arg) -> PrVP (aNP aS)       -> PrCl a  -> PrVP (aNP a) ;   -- she tells X that I am here
  SlashV2V  : (a : Arg) -> PrVP (aNP aV)       -> PrVPI a -> PrVP (aNP a) ;   -- she forces X to sleep
  SlashV2A  : (a : Arg) -> PrVP (aNP aA)       -> PrAP a  -> PrVP (aNP a) ;   -- she makes X crazy
  SlashV2N  : (a : Arg) -> PrVP (aNP aN)       -> PrCN a  -> PrVP (aNP a) ;   -- she makes X a professor
  SlashV2Q  : (a : Arg) -> PrVP (aNP aA)       -> PrQCl a -> PrVP (aNP a) ;   -- she asks X who is here

  InfVP     : (a : Arg) -> PrVP a -> PrVPI a ;                                -- to love X

  UseAP     : (a : Arg) -> Ant -> Tense -> Pol -> PrAP a      -> PrVP a ;     -- she is married to X
  UseAdv    : (a : Arg) -> Ant -> Tense -> Pol -> PrAdv a     -> PrVP a ;     -- she is in X
  UseCN     : (a : Arg) -> Ant -> Tense -> Pol -> PrCN a      -> PrVP a ;     -- she is a member of X
  UseNP     :              Ant -> Tense -> Pol -> NP          -> PrVP aNone ; -- she is the person
  UseS      :              Ant -> Tense -> Pol -> PrCl aNone  -> PrVP aNone ; -- the fact is that she sleeps
  UseQ      :              Ant -> Tense -> Pol -> PrQCl aNone -> PrVP aNone ; -- the question is who sleeps
  UseVP     :              Ant -> Tense -> Pol -> PrVPI aNone -> PrVP aNone ; -- the goal is to sleep

  PredVP    : (a : Arg) -> NP -> PrVP a -> PrCl a ;

  SlashClNP : (a : Arg) -> PrCl (aNP a) -> NP -> PrCl a ;    -- slash consumption: hon tittar på + oss

  ReflVP    : (a : Arg) -> PrVP (aNP a) -> PrVP a ;              -- refl on first position (direct object)
  ReflVP2   : (a : Arg) -> PrVP (aNP (aNP a)) -> PrVP (aNP a) ;  -- refl on second position (indirect object)

  QuestVP    : (a : Arg) -> IP   -> PrVP a         -> PrQCl a ; 
  QuestSlash : (a : Arg) -> IP   -> PrQCl (aNP a)  -> PrQCl a ;
  QuestCl    : (a : Arg)         -> PrCl a         -> PrQCl a ;
  QuestIAdv  : (a : Arg) -> IAdv -> PrCl a         -> PrQCl a ;
  QuestIComp : Ant -> Tense -> Pol -> IComp -> NP  -> PrQCl aNone ; -- where is she

  UseCl  : PrCl aNone  -> PrS ;
  UseQCl : PrQCl aNone -> PrS ; -- deprecate QS

  UseAdvCl : PrAdv aNone -> PrCl aNone -> PrS ;  -- lift adv to front
  
  UttPrS  : PrS -> Utt ;

  AdvCl   : (a : Arg) -> PrAdv a -> PrCl aNone  -> PrCl a ; 

  AdvQCl  : (a : Arg) -> PrAdv a -> PrQCl aNone -> PrQCl a ; 

-- relatives
  RelCl    : PrCl aNone             -> RS ;
  RelVP    : RP -> PrVP aNone       -> RS ;
  RelSlash : RP -> PrCl (aNP aNone) -> RS ;

-- imperatives

  PrImpSg : PrVP aNone -> Utt ;
  PrImpPl : PrVP aNone -> Utt ;  

-- participles as adjectives

  PresPartAP      : (a : Arg) -> PrV a       -> PrAP a ;
  PastPartAP      : (a : Arg) -> PrV (aNP a) -> PrAP a ;
  AgentPastPartAP : (a : Arg) -> PrV (aNP a) -> NP -> PrAP a ;

-- nominalization
  NomVPNP   : PrVPI aNone -> NP ;   -- translating a document

-- other uses of VP's
  ByVP      : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- by translating a document
  WhenVP    : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- when translating a document
  BeforeVP  : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- before translating a document
  AfterVP   : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- after translating a document
  InOrderVP : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- in order to translate a document
  WithoutVP : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- without translating a document

-- PrVP coordination

  StartVPC : (a : Arg) -> Conj -> PrVP a -> PrVP a  -> VPC a ;
  ContVPC  : (a : Arg)         -> PrVP a -> VPC a   -> VPC a ;
  UseVPC   : (a : Arg) -> VPC a -> PrVP a ;

-- clause coordination, including "she loves and we look at (her)"
  StartClC : (a : Arg) -> Conj   -> PrCl a -> PrCl a  -> ClC a ;
  ContClC  : (a : Arg) -> PrCl a -> ClC a  -> ClC a ;
  UseClC   : (a : Arg) -> ClC a  -> PrCl a ;

  ComplAdv : (a : Arg) -> PrAdv (aNP a) -> NP -> PrAdv a ; -- typically: formation of preposition phrase

-- subjunction ; we want to preserve the order in translation
-- Pre is more specialized to make inverted S order
---- Imp to do

  SubjUttPreS  : Subj -> PrCl aNone -> PrCl aNone -> Utt ;
  SubjUttPreQ  : Subj -> PrCl aNone -> PrQCl aNone -> Utt ;
  SubjUttPost  : Subj -> PrCl aNone -> Utt -> Utt ;

}