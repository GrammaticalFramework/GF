abstract NDPred = Cat [Ant,NP,Utt,IP,IAdv,IComp,Conj,RS,RP] ** {

cat
--<  Arg ;

--<  PrV Arg ;
  PrV_none ; PrV_np ; PrV_v ; PrV_s ; PrV_q ; PrV_a ; PrV_n ;
             PrV_np_np ; PrV_np_v ; PrV_np_s ; PrV_np_q ; PrV_np_a ; PrV_np_n ;

--<  PrVP Arg ;
  PrVP_none ; PrVP_np ; PrVP_v ; PrVP_s ; PrVP_q ; PrVP_a ; PrVP_n ;
             PrVP_np_np ; PrVP_np_v ; PrVP_np_s ; PrVP_np_q ; PrVP_np_a ; PrVP_np_n ;

--<  PrVPI Arg ;  -- infinitive VP
  PrVPI_none ; 
  PrVPI_np ;

--<  VPC Arg ;  -- conjunction of VP
  VPC_none ; 
  VPC_np ;

  Tense ;
  Pol ;

--<  PrCl Arg ;
  PrCl_none ; 
  PrCl_np ;

--<  ClC Arg ;  -- conjunction of Cl
  ClC_none ; 
  ClC_np ;

--<  PrQCl Arg ;
  PrQCl_none ; 
  PrQCl_np ;

--<  PrAdv Arg ;
  PrAdv_none ; 
  PrAdv_np ;

  PrS ;

--<  PrAP Arg ;
  PrAP_none ; 
  PrAP_np ;

--<  PrCN Arg ; -- the country he became the president of
  PrCN_none ; 
  PrCN_np ;

fun
--<  aNone, aS, aV, aQ, aA, aN : Arg ;
--<  aNP : Arg -> Arg ;

  TPres, TPast, TFut, TCond : Tense ;
  PPos, PNeg : Pol ;
  ASimul, AAnter : Ant ;

--<  UseV           : (a : Arg) -> Ant -> Tense -> Pol -> PrV a -> PrVP a ;
  UseV_none  : Ant -> Tense -> Pol -> PrV_none  -> PrVP_none ;
  UseV_np    : Ant -> Tense -> Pol -> PrV_np    -> PrVP_np ;
  UseV_v     : Ant -> Tense -> Pol -> PrV_v     -> PrVP_v ;
  UseV_s     : Ant -> Tense -> Pol -> PrV_s     -> PrVP_s ;
  UseV_a     : Ant -> Tense -> Pol -> PrV_a     -> PrVP_a ;
  UseV_q     : Ant -> Tense -> Pol -> PrV_q     -> PrVP_q ;
  UseV_n     : Ant -> Tense -> Pol -> PrV_v     -> PrVP_n ;
  UseV_np_np : Ant -> Tense -> Pol -> PrV_np_np -> PrVP_np_np ;
  UseV_np_v  : Ant -> Tense -> Pol -> PrV_np_v  -> PrVP_np_v  ;
  UseV_np_s  : Ant -> Tense -> Pol -> PrV_np_s  -> PrVP_np_s  ;
  UseV_np_a  : Ant -> Tense -> Pol -> PrV_np_a  -> PrVP_np_a  ;
  UseV_np_q  : Ant -> Tense -> Pol -> PrV_np_q  -> PrVP_np_q  ;
  UseV_np_n  : Ant -> Tense -> Pol -> PrV_np_n  -> PrVP_np_n  ;

--<  PassUseV   : (a : Arg) -> Ant -> Tense -> Pol -> PrV (aNP a) -> PrVP a ;
  PassUseV_none  : Ant -> Tense -> Pol -> PrV_np    -> PrVP_none ;
  PassUseV_np    : Ant -> Tense -> Pol -> PrV_np_np -> PrVP_np ;
  PassUseV_v     : Ant -> Tense -> Pol -> PrV_np_v  -> PrVP_v  ;
  PassUseV_s     : Ant -> Tense -> Pol -> PrV_np_s  -> PrVP_s  ;
  PassUseV_a     : Ant -> Tense -> Pol -> PrV_np_a  -> PrVP_a  ;
  PassUseV_q     : Ant -> Tense -> Pol -> PrV_np_q  -> PrVP_q  ;
  PassUseV_n     : Ant -> Tense -> Pol -> PrV_np_n  -> PrVP_n  ;

--<  AgentPassUseV  : (a : Arg) -> Ant -> Tense -> Pol -> PrV (aNP a) -> NP -> PrVP a ;
  AgentPassUseV_none  : Ant -> Tense -> Pol -> PrV_np    -> NP -> PrVP_none ;
  AgentPassUseV_np    : Ant -> Tense -> Pol -> PrV_np_np -> NP -> PrVP_np ;
  AgentPassUseV_v     : Ant -> Tense -> Pol -> PrV_np_v  -> NP -> PrVP_v  ;
  AgentPassUseV_s     : Ant -> Tense -> Pol -> PrV_np_s  -> NP -> PrVP_s  ;
  AgentPassUseV_a     : Ant -> Tense -> Pol -> PrV_np_a  -> NP -> PrVP_a  ;
  AgentPassUseV_q     : Ant -> Tense -> Pol -> PrV_np_q  -> NP -> PrVP_q  ;
  AgentPassUseV_n     : Ant -> Tense -> Pol -> PrV_np_n  -> NP -> PrVP_n  ;

--<  ComplV2   : (a : Arg) -> PrVP (aNP a)        -> NP      -> PrVP a ;         -- she loves him
  ComplV2_none : PrVP_np -> NP -> PrVP_none ;

--<  ComplVS   : (a : Arg) -> PrVP aS             -> PrCl  a -> PrVP a ;         -- she says that I am here
  ComplVS_none : PrVP_s -> PrCl_none -> PrVP_none ;
  ComplVS_np   : PrVP_s -> PrCl_np   -> PrVP_np ;

--<  ComplVV   : (a : Arg) -> PrVP aV             -> PrVPI  a -> PrVP a ;        -- she wants to sleep
  ComplVV_none : PrVP_v -> PrVPI_none -> PrVP_none ;
  ComplVV_np   : PrVP_v -> PrVPI_np   -> PrVP_np ;

--<  ComplVQ   : (a : Arg) -> PrVP aQ             -> PrQCl a -> PrVP a ;         -- she wonders who is here
  ComplVQ_none : PrVP_q -> PrQCl_none -> PrVP_none ;

--<  ComplVA   : (a : Arg) -> PrVP aA             -> PrAP  a -> PrVP a ;         -- she becomes old
  ComplVA_none : PrVP_a -> PrAP_none -> PrVP_none ;

--<  ComplVN   : (a : Arg) -> PrVP aN             -> PrCN  a -> PrVP a ;         -- she becomes a professor
  ComplVN_none : PrVP_n -> PrCN_none -> PrVP_none ;

--<  SlashV3   : (a : Arg) -> PrVP (aNP (aNP a))  -> NP      -> PrVP (aNP a) ;   -- she shows X to him
  SlashV3_none : PrVP_np_np -> NP    -> PrVP_np ;

--<  SlashV2S  : (a : Arg) -> PrVP (aNP aS)       -> PrCl a  -> PrVP (aNP a) ;   -- she tells X that I am here
  SlashV2S_none : PrVP_np_s -> PrCl_none -> PrVP_np ;

--<  SlashV2V  : (a : Arg) -> PrVP (aNP aV)       -> PrVPI a -> PrVP (aNP a) ;   -- she forces X to sleep
  SlashV2V_none : PrVP_np_v -> PrVPI_none -> PrVP_np ;
  SlashV2V_np   : PrVP_np_v -> PrVPI_np -> PrVP_np_np ;

--<  SlashV2A  : (a : Arg) -> PrVP (aNP aA)       -> PrAP a  -> PrVP (aNP a) ;   -- she makes X crazy
  SlashV2A_none : PrVP_np_a -> PrAP_none -> PrVP_np ;

--<  SlashV2N  : (a : Arg) -> PrVP (aNP aN)       -> PrCN a  -> PrVP (aNP a) ;   -- she makes X a professor
  SlashV2N_none : PrVP_np_n -> PrCN_none -> PrVP_np ;

--<  SlashV2Q  : (a : Arg) -> PrVP (aNP aA)       -> PrQCl a -> PrVP (aNP a) ;   -- she asks X who is here
  SlashV2Q_none : PrVP_np_q -> PrQCl_none -> PrVP_np ;

--<  UseAP     : (a : Arg) -> Ant -> Tense -> Pol -> PrAP a  -> PrVP a ;         -- she is married to X
  UseAP_none : Ant -> Tense -> Pol -> PrAP_none -> PrVP_none ;
  UseAP_np   : Ant -> Tense -> Pol -> PrAP_np   -> PrVP_np ;

--<  UseAdv    : (a : Arg) -> Ant -> Tense -> Pol -> PrAdv a -> PrVP a ;         -- she is in X
  UseAdv_none : Ant -> Tense -> Pol -> PrAdv_none -> PrVP_none ;
  UseAdv_np   : Ant -> Tense -> Pol -> PrAdv_np   -> PrVP_np ;

--<  UseCN     : (a : Arg) -> Ant -> Tense -> Pol -> PrCN a  -> PrVP a ;         -- she is a member of X
  UseCN_none : Ant -> Tense -> Pol -> PrCN_none -> PrVP_none ;
  UseCN_np   : Ant -> Tense -> Pol -> PrCN_np   -> PrVP_np ;

-- the following are only for aNone
  UseNP_none : Ant -> Tense -> Pol -> NP -> PrVP_none ;
  UseS_none  : Ant -> Tense -> Pol -> PrCl_none  -> PrVP_none ; -- the fact is that she sleeps
  UseQ_none  : Ant -> Tense -> Pol -> PrQCl_none -> PrVP_none ; -- the question is who sleeps
  UseVP_none : Ant -> Tense -> Pol -> PrVPI_none -> PrVP_none ; -- the goal is to sleep

--<  InfVP    : (a : Arg) -> PrVP a -> PrVPI a ;
  InfVP_none : PrVP_none -> PrVPI_none ;
  InfVP_np   : PrVP_np -> PrVPI_np ;

--<  PredVP    : (a : Arg) -> NP -> PrVP a -> PrCl a ;
  PredVP_none : NP -> PrVP_none -> PrCl_none ;
  PredVP_np   : NP -> PrVP_np -> PrCl_np ;

--<  SlashClNP : (a : Arg) -> PrCl (aNP a) -> NP -> PrCl a ;    -- slash consumption: hon tittar på + oss
  SlashClNP_none : PrCl_np -> NP -> PrCl_none ;

--<  ReflVP    : (a : Arg) -> PrVP (aNP a) -> PrVP a ;              -- refl on first position (direct object)
  ReflVP_none : PrVP_np -> PrVP_none ;
  ReflVP_np : PrVP_np_np -> PrVP_np ;
  ReflVP_v  : PrVP_np_v -> PrVP_v ;
  ReflVP_s  : PrVP_np_s -> PrVP_s ;
  ReflVP_q  : PrVP_np_q -> PrVP_q ;
  ReflVP_a  : PrVP_np_a -> PrVP_a ;
  ReflVP_n  : PrVP_np_n -> PrVP_n ;

--<  ReflVP2   : (a : Arg) -> PrVP (aNP (aNP a)) -> PrVP (aNP a) ;  -- refl on second position (indirect object)
  ReflVP2_np : PrVP_np_np -> PrVP_np ;

--<  QuestVP    : (a : Arg) -> IP   -> PrVP a         -> PrQCl a ; 
  QuestVP_none : IP -> PrVP_none -> PrQCl_none ;

--< QuestSlash : (a : Arg) -> IP   -> PrQCl (aNP a)  -> PrQCl a ;
  QuestSlash_none : IP   -> PrQCl_np  -> PrQCl_none ;

--<  QuestCl    : (a : Arg)         -> PrCl a         -> PrQCl a ;
  QuestCl_none : PrCl_none -> PrQCl_none ;
  QuestCl_np : PrCl_np -> PrQCl_np ;

--<  QuestIAdv  : (a : Arg) -> IAdv -> PrCl a         -> PrQCl a ;
  QuestIAdv_none : IAdv -> PrCl_none -> PrQCl_none ;

  QuestIComp_none : Ant -> Tense -> Pol -> IComp -> NP  -> PrQCl_none ; -- where is she


--<  UseCl  : PrCl aNone  -> PrS ;
  UseCl_none : PrCl_none -> PrS ;

--<  UseQCl : PrQCl aNone -> PrS ; 
  UseQCl_none : PrQCl_none -> PrS ;

--<  UseAdvCl : PrAdv aNone -> PrCl aNone -> PrS ;  -- lift adv to front
  UseAdvCl_none : PrAdv_none -> PrCl_none -> PrS ;

  UttPrS  : PrS -> Utt ;

--<  AdvCl   : (a : Arg) -> PrAdv a -> PrCl aNone  -> PrCl a ; 
  AdvCl_none : PrAdv_none -> PrCl_none -> PrCl_none ;
  AdvCl_np : PrAdv_np -> PrCl_none -> PrCl_np ;

--<  AdvQCl  : (a : Arg) -> PrAdv a -> PrQCl aNone -> PrQCl a ; 
  AdvQCl_none : PrAdv_none -> PrQCl_none -> PrQCl_none ;
  AdvQCl_np : PrAdv_np -> PrQCl_none -> PrQCl_np ;

-- relatives: just one of each
  RelCl_none    : PrCl_none         -> RS ;
  RelVP_none    : RP -> PrVP_none   -> RS ;
  RelSlash_none : RP -> PrCl_np     -> RS ;

-- imperatives: just one of each

  PrImpSg : PrVP_none -> Utt ;
  PrImpPl : PrVP_none -> Utt ;  

-- participles as adjectives

--<  PresPartAP      : (a : Arg) -> PrV a       -> PrAP a ;
  PresPartAP_none : PrV_none -> PrAP_none ;
  PresPartAP_np : PrV_np -> PrAP_np ;

--<  PastPartAP      : (a : Arg) -> PrV (aNP a) -> PrAP a ;
  PastPartAP_none : PrV_np -> PrAP_none ;

--<  AgentPastPartAP : (a : Arg) -> PrV (aNP a) -> NP -> PrAP a ;
  AgentPastPartAP_none : PrV_np -> NP -> PrAP_none ;

-- for aNone only
  NomVPNP_none   : PrVPI_none -> NP ;   -- translating a document

--<  ByVP      : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- by translating a document
  ByVP_none    :      PrVP_none -> PrVPI_none -> PrVP_none ; 
  
--<  WhenVP    : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- when translating a document
  WhenVP_none    :      PrVP_none -> PrVPI_none -> PrVP_none ; 

--<  BeforeVP  : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- before translating a document
  BeforeVP_none    :      PrVP_none -> PrVPI_none -> PrVP_none ; 

--<  AfterVP   : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- after translating a document
  AfterVP_none    :      PrVP_none -> PrVPI_none -> PrVP_none ; 

--<  InOrderVP : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- in order to translate a document
  InOrderVP_none    :      PrVP_none -> PrVPI_none -> PrVP_none ; 

--<  WithoutVP : (a : Arg) -> PrVP a -> PrVPI aNone -> PrVP a ;  -- without translating a document
  WithoutVP_none    :      PrVP_none -> PrVPI_none -> PrVP_none ; 


-- PrVP coordination

--<  StartVPC : (a : Arg) -> Conj -> PrVP a -> PrVP a  -> VPC a ;
  StartVPC_none : Conj -> PrVP_none -> PrVP_none  -> VPC_none ;
  StartVPC_np : Conj -> PrVP_np -> PrVP_np  -> VPC_np ;
  ---- ...

--<  ContVPC  : (a : Arg)         -> PrVP a -> VPC a   -> VPC a ;
  ContVPC_none : PrVP_none -> VPC_none  -> VPC_none ;
  ContVPC_np : PrVP_np -> VPC_np  -> VPC_np ;
  ---- ...

--<  UseVPC   : (a : Arg) -> VPC a -> PrVP a ;
  UseVPC_none : VPC_none -> PrVP_none ; 
  UseVPC_np : VPC_np -> PrVP_np ; 

-- clause coordination, including "she loves and we look at (her)"

--<  StartClC : (a : Arg) -> Conj   -> PrCl a -> PrCl a  -> ClC a ;
  StartClC_none : Conj -> PrCl_none -> PrCl_none  -> ClC_none ;
  StartClC_np : Conj -> PrCl_np -> PrCl_np  -> ClC_np ;  

--<  ContClC  : (a : Arg) -> PrCl a -> ClC a  -> ClC a ;
  ContClC_none : PrCl_none -> ClC_none  -> ClC_none ;
  ContClC_np : PrCl_np -> ClC_np  -> ClC_np ;  

--<  UseClC   : (a : Arg) -> ClC a  -> PrCl a ;
  UseClC_none : ClC_none -> PrCl_none ; 
  UseClC_np : ClC_np -> PrCl_np ; 

--<  ComplAdv : (a : Arg) -> PrAdv (aNP a) -> NP -> PrAdv a ; -- typically: formation of preposition phrase
  ComplAdv_none : PrAdv_np -> NP -> PrAdv_none ;

--<  SubjUttPreS  : Subj -> PrCl aNone -> PrCl aNone -> Utt ;
  SubjUttPreS  : Subj -> PrCl_none -> PrCl_none -> Utt ;
--<  SubjUttPreQ  : Subj -> PrCl aNone -> PrQCl aNone -> Utt ;
  SubjUttPreQ  : Subj -> PrCl_none -> PrQCl_none -> Utt ;
--<  SubjUttPost  : Subj -> PrCl aNone -> Utt -> Utt ;
  SubjUttPost  : Subj -> PrCl_none -> Utt -> Utt ;


}