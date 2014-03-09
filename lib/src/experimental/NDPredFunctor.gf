incomplete concrete NDPredFunctor of NDPred = 
  Cat [Ant,NP,Utt,IP,IAdv,Conj,RS,RP,Subj] ** 
  open 
    PredInterface,
    Pred,
    ParamX,
    Prelude 
  in {

------------------------------------
-- lincats
-------------------------------------

lincat
  Tense = Pred.Tense ;
  Pol = Pred.Pol ;

  PrV_none, PrV_np, PrV_v, PrV_s, PrV_q, PrV_a, PrV_n,
             PrV_np_np, PrV_np_v, PrV_np_s, PrV_np_q, PrV_np_a, PrV_np_n = Pred.PrV ;

  PrVP_none, PrVP_np, PrVP_v, PrVP_s, PrVP_q, PrVP_a, PrVP_n,
             PrVP_np_np, PrVP_np_v, PrVP_np_s, PrVP_np_q, PrVP_np_a, PrVP_np_n = Pred.PrVP ;

  PrVPI_none, PrVPI_np = Pred.PrVPI ;

  PrCl_none, PrCl_np = Pred.PrCl ;

  PrQCl_none, PrQCl_np = Pred.PrQCl ;

  VPC_none, VPC_np = Pred.VPC ;

  ClC_none, ClC_np = Pred.ClC ;

  PrAdv_none, PrAdv_np = Pred.PrAdv ;

  PrS = Pred.PrS ;

  PrAP_none, PrAP_np = Pred.PrAP ;

  PrCN_none, PrCN_np = Pred.PrCN ;

-- reference linearizations for chunking
---- should be by functor as well

linref
  PrVP_none, PrVP_np, PrVP_v, PrVP_s, PrVP_q, PrVP_a, PrVP_n,
             PrVP_np_np, PrVP_np_v, PrVP_np_s, PrVP_np_q, PrVP_np_a, PrVP_np_n
    = linrefPrVP ;
  PrCl_none, PrCl_np  = linrefPrCl ;
  PrQCl_none, PrQCl_np = linrefPrQCl ;
  PrAdv_none, PrAdv_np = linrefPrAdv ;
----  PrAP_none, PrAP_np  = \ap  -> ap.s ! defaultAgr ++ ap.obj1 ! defaultAgr ;  
----  PrCN_none, PrCN_np  = \cn  -> cn.s ! Sg ++ cn.obj1 ! defaultAgr ; 
  
----------------------------
--- linearization rules ----
----------------------------

lin

-- standard general

  TPres  = Pred.TPres ;
  TPast  = Pred.TPast ;
  TFut   = Pred.TFut ;
  TCond  = Pred.TCond ;
  ASimul = Pred.ASimul ;
  AAnter = Pred.AAnter ;
  PPos   = Pred.PPos ;
  PNeg   = Pred.PNeg ;

  UseV_none, UseV_np, UseV_v, UseV_s, UseV_q, UseV_a, UseV_n, UseV_np_np, UseV_np_v, UseV_np_s, UseV_np_q, UseV_np_a, UseV_np_n 
    = Pred.UseV Pred.aNone ;
  PassUseV_none, PassUseV_np, PassUseV_v, PassUseV_s, PassUseV_q, PassUseV_a, PassUseV_n
    = Pred.PassUseV Pred.aNone ;
  AgentPassUseV_none, AgentPassUseV_np, AgentPassUseV_v, AgentPassUseV_s, AgentPassUseV_q, AgentPassUseV_a, AgentPassUseV_n
    = Pred.AgentPassUseV Pred.aNone ;

  UseAP_none, UseAP_np 
    = Pred.UseAP Pred.aNone ;
  UseCN_none, UseCN_np 
    = Pred.UseCN Pred.aNone ;
  UseAdv_none, UseAdv_np 
    = Pred.UseAdv Pred.aNone ;
  UseNP_none
    = Pred.UseNP ;
  UseS_none
    = Pred.UseS ;
  UseQ_none
    = Pred.UseQ ;
  UseVP_none
    = Pred.UseVP ;

  ComplV2_none
    = Pred.ComplV2 Pred.aNone ;
  ComplVV_none, ComplVV_np
    = Pred.ComplVV Pred.aNone ;
  ComplVS_none, ComplVS_np
    = Pred.ComplVS Pred.aNone ;
  ComplVA_none
    = Pred.ComplVA Pred.aNone ;
  ComplVQ_none
    = Pred.ComplVQ Pred.aNone ;
  ComplVN_none
    = Pred.ComplVN Pred.aNone ;

  SlashV3_none
    = Pred.SlashV3 Pred.aNone ;
  SlashV2V_none, SlashV2V_np
    = Pred.SlashV2V Pred.aNone ;
  SlashV2S_none
    = Pred.SlashV2S Pred.aNone ;
  SlashV2Q_none
    = Pred.SlashV2Q Pred.aNone ;
  SlashV2A_none
    = Pred.SlashV2A Pred.aNone ;
  SlashV2N_none
    = Pred.SlashV2N Pred.aNone ;

  ReflVP_none, ReflVP_np, ReflVP_v, ReflVP_s, ReflVP_q, ReflVP_a, ReflVP_n
    = Pred.ReflVP Pred.aNone ;
  ReflVP2_np
    = Pred.ReflVP2 Pred.aNone ;

  InfVP_none, InfVP_np 
    = Pred.InfVP Pred.aNone ;

  PredVP_none, PredVP_np 
    = Pred.PredVP Pred.aNone ;

  SlashClNP_none 
    = Pred.SlashClNP Pred.aNone ;

  QuestCl_none, QuestCl_np
    = Pred.QuestCl Pred.aNone ;

  QuestIAdv_none 
    = Pred.QuestIAdv Pred.aNone ;

  QuestIComp_none 
    = Pred.QuestIComp ;

  QuestVP_none 
    = Pred.QuestVP Pred.aNone ;

  QuestSlash_none
    = Pred.QuestSlash Pred.aNone ;

  UseCl_none 
    = Pred.UseCl ;
  UseQCl_none 
    = Pred.UseQCl ;

  UseAdvCl_none
    = Pred.UseAdvCl ;

  UttPrS 
    = Pred.UttPrS ;

  AdvCl_none, AdvCl_np
    = Pred.AdvCl Pred.aNone ;
  AdvQCl_none, AdvQCl_np
    = Pred.AdvQCl Pred.aNone ;

----  RelCl_none
----    = Pred.RelCl Pred.aNone ;
  RelVP_none
    = Pred.RelVP ;
  RelSlash_none
    = Pred.RelSlash ;

  PrImpSg
    = Pred.PrImpSg ;
  PrImpPl
    = Pred.PrImpPl ;

  PresPartAP_none, PresPartAP_np
    = Pred.PresPartAP Pred.aNone ;

  PastPartAP_none
    = Pred.PastPartAP Pred.aNone ;

  AgentPastPartAP_none
    = Pred.AgentPastPartAP Pred.aNone ;

  NomVPNP_none
    = Pred.NomVPNP ;

  ByVP_none
    = Pred.ByVP Pred.aNone ;
  WhenVP_none
    = Pred.WhenVP Pred.aNone ;
  BeforeVP_none
    = Pred.BeforeVP Pred.aNone ;
  AfterVP_none
    = Pred.AfterVP Pred.aNone ;
  InOrderVP_none
    = Pred.InOrderVP Pred.aNone ;
  WithoutVP_none
    = Pred.WithoutVP Pred.aNone ;

  StartVPC_none, StartVPC_np
    = Pred.StartVPC Pred.aNone ;
  ContVPC_none, ContVPC_np
    = Pred.ContVPC Pred.aNone ;
  UseVPC_none, UseVPC_np
    = Pred.UseVPC Pred.aNone ;

  StartClC_none, StartClC_np
    = Pred.StartClC Pred.aNone ;
  ContClC_none, ContClC_np
    = Pred.ContClC Pred.aNone ;
  UseClC_none, UseClC_np
    = Pred.UseClC Pred.aNone ;

  ComplAdv_none 
    = Pred.ComplAdv Pred.aNone ;

  SubjUttPreS
    = Pred.SubjUttPreS ;
  SubjUttPreQ
    = Pred.SubjUttPreQ ;
  SubjUttPost
    = Pred.SubjUttPost ;

}