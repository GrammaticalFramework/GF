abstract SmallPred = 
  RGLBase  - [Pol,Tense]
** {

cat
  PrV_none ; PrV_np ; PrV_v ; PrV_s ; PrV_q ; PrV_a ; PrV_n ;
             PrV_np_np ; PrV_np_v ; PrV_np_s ; PrV_np_q ; PrV_np_a ; PrV_np_n ;

  PrVP_none ; PrVP_np ; PrVP_v ; PrVP_s ; PrVP_q ; PrVP_a ; PrVP_n ;
             PrVP_np_np ; PrVP_np_v ; PrVP_np_s ; PrVP_np_q ; PrVP_np_a ; PrVP_np_n ;


  Tense ;
  Pol ;

  PrCl_none ; 

  PrQCl_none ; 

  PrAdv_none ; 

  PrS ;

  PrAP_none ; 

  PrCN_none ; 

fun
  TPres, TPast, TFut, TCond : Tense ;
  PPos, PNeg : Pol ;
  ASimul, AAnter : Ant ;

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

--  ComplV2_none : PrVP_np -> NP -> PrVP_none ;

--  UseAP_none : Ant -> Tense -> Pol -> PrAP_none -> PrVP_none ;

  UseAdv_none : Ant -> Tense -> Pol -> PrAdv_none -> PrVP_none ;

  UseCN_none : Ant -> Tense -> Pol -> PrCN_none -> PrVP_none ;

  UseNP_none : Ant -> Tense -> Pol -> NP -> PrVP_none ;

  PredVP_none : NP -> PrVP_none -> PrCl_none ;
  PredVP_np : NP -> PrVP_np -> PrCl_none ;
  PredVP_v : NP -> PrVP_v -> PrCl_none ;
  PredVP_a : NP -> PrVP_a -> PrCl_none ;
  PredVP_s : NP -> PrVP_s -> PrCl_none ;
  PredVP_q : NP -> PrVP_q -> PrCl_none ;
  PredVP_np_np : NP -> PrVP_np -> PrCl_none ;
  PredVP_np_v : NP -> PrVP_v -> PrCl_none ;
  PredVP_np_a : NP -> PrVP_a -> PrCl_none ;
  PredVP_np_s : NP -> PrVP_s -> PrCl_none ;
  PredVP_np_q : NP -> PrVP_q -> PrCl_none ;

  Pred2VP_none : NP -> PrVP_none -> NP -> PrCl_none ;
  Pred2VP_np : NP -> PrVP_np -> NP -> PrCl_none ;
  Pred2VP_v : NP -> PrVP_v -> NP -> PrCl_none ;
  Pred2VP_a : NP -> PrVP_a -> NP -> PrCl_none ;
  Pred2VP_s : NP -> PrVP_s -> NP -> PrCl_none ;
  Pred2VP_q : NP -> PrVP_q -> NP -> PrCl_none ;
  Pred2VP_np_np : NP -> PrVP_np -> NP -> PrCl_none ;
  Pred2VP_np_v : NP -> PrVP_v -> NP -> PrCl_none ;
  Pred2VP_np_a : NP -> PrVP_a -> NP -> PrCl_none ;
  Pred2VP_np_s : NP -> PrVP_s -> NP -> PrCl_none ;
  Pred2VP_np_q : NP -> PrVP_q -> NP -> PrCl_none ;

  PredAP_none : Ant -> Tense -> Pol -> NP -> PrAP_none -> PrCl_none ;

  QuestVP_none : IP -> PrVP_none -> PrQCl_none ;

  QuestCl_none : PrCl_none -> PrQCl_none ;

  UseCl_none : PrCl_none -> PrS ;

  UseQCl_none : PrQCl_none -> PrS ;

  UttPrS  : PrS -> Utt ;

---- Lift

fun
  LiftV  : V  -> PrV_none ;
  LiftV2 : V2 -> PrV_np ;
  LiftVS : VS -> PrV_s ;
  LiftVQ : VQ -> PrV_q ;
  LiftVV : VV -> PrV_v ;
  LiftVA : VA -> PrV_a ;
  LiftVN : VA -> PrV_n ; ----

  LiftV3  : V3  -> PrV_np_np ;
  LiftV2S : V2S -> PrV_np_s ;
  LiftV2Q : V2Q -> PrV_np_q ;
  LiftV2V : V2V -> PrV_np_v ;
  LiftV2A : V2A -> PrV_np_a ;
  LiftV2N : V2A -> PrV_np_n ; ----

  LiftAP  : AP  -> PrAP_none ;
  LiftCN  : CN  -> PrCN_none ;

  LiftAdv  : Adv  -> PrAdv_none ;
  LiftAdV  : AdV  -> PrAdv_none ;


------- Chunk

cat
  Chunks ;
  Chunk ;

fun
  OneChunk : Chunk -> Chunks ;
  PlusChunk : Chunk -> Chunks -> Chunks ;

  ChunkPhr : Chunks -> Phr ;

fun

  AP_Chunk : AP -> Chunk ;
  AdA_Chunk : AdA -> Chunk ;
  Adv_Chunk : Adv -> Chunk ;
  AdV_Chunk : AdV -> Chunk ;
  AdN_Chunk : AdN -> Chunk ;
  Cl_Chunk : PrCl_none -> Chunk ;
  QCl_Chunk : PrQCl_none -> Chunk ;
  CN_Pl_Chunk : CN -> Chunk ;
  CN_Sg_Chunk : CN -> Chunk ;
  CN_Pl_Gen_Chunk : CN -> Chunk ;
  CN_Sg_Gen_Chunk : CN -> Chunk ;
  Conj_Chunk : Conj -> Chunk ;
  IAdv_Chunk : IAdv -> Chunk ;
  IP_Chunk : IP -> Chunk ;
  NP_Nom_Chunk : NP -> Chunk ;
  NP_Acc_Chunk : NP -> Chunk ;
  NP_Gen_Chunk : NP -> Chunk ;
  Numeral_Nom_Chunk : Numeral -> Chunk ;
  Numeral_Gen_Chunk : Numeral -> Chunk ;
  Ord_Nom_Chunk : Ord -> Chunk ;
  Ord_Gen_Chunk : Ord -> Chunk ;
  Predet_Chunk : Predet -> Chunk ;
  Prep_Chunk : Prep -> Chunk ;
  RP_Nom_Chunk : RP -> Chunk ;
  RP_Gen_Chunk : RP -> Chunk ;
  RP_Acc_Chunk : RP -> Chunk ;
  Subj_Chunk : Subj -> Chunk ;

  VP_none_Chunk, VP_none_inf_Chunk : PrVP_none -> Chunk ;
  VP_np_Chunk,   VP_np_inf_Chunk : PrVP_np -> Chunk ;
  VP_s_Chunk,    VP_s_inf_Chunk : PrVP_s -> Chunk ;
  VP_v_Chunk,   VP_v_inf_Chunk : PrVP_v -> Chunk ;
  VP_a_Chunk,   VP_a_inf_Chunk : PrVP_a -> Chunk ;
  VP_q_Chunk,   VP_q_inf_Chunk : PrVP_q -> Chunk ;
  VP_np_np_Chunk,   VP_np_np_inf_Chunk : PrVP_np_np -> Chunk ;
  VP_np_s_Chunk,    VP_np_s_inf_Chunk : PrVP_np_s -> Chunk ;
  VP_np_v_Chunk,   VP_np_v_inf_Chunk : PrVP_np_v -> Chunk ;
  VP_np_q_Chunk,   VP_np_q_inf_Chunk : PrVP_np_q -> Chunk ;
  VP_np_a_Chunk,   VP_np_a_inf_Chunk : PrVP_np_a -> Chunk ;

  V_none_prespart_Chunk,  V_none_pastpart_Chunk : PrV_none -> Chunk ;
  V_np_prespart_Chunk,  V_np_pastpart_Chunk : PrV_np -> Chunk ;
  V_s_prespart_Chunk,  V_s_pastpart_Chunk : PrV_s -> Chunk ;
  V_v_prespart_Chunk,  V_v_pastpart_Chunk : PrV_v -> Chunk ;
  V_q_prespart_Chunk,  V_q_pastpart_Chunk : PrV_q -> Chunk ;
  V_a_prespart_Chunk,  V_a_pastpart_Chunk : PrV_q -> Chunk ;

  V_np_np_prespart_Chunk,  V_np_np_pastpart_Chunk : PrV_np_np -> Chunk ;
  V_np_s_prespart_Chunk,  V_np_s_pastpart_Chunk : PrV_np_s -> Chunk ;
  V_np_v_prespart_Chunk,  V_np_v_pastpart_Chunk : PrV_np_v -> Chunk ;
  V_np_q_prespart_Chunk,  V_np_q_pastpart_Chunk : PrV_np_q -> Chunk ;
  V_np_a_prespart_Chunk,  V_np_a_pastpart_Chunk : PrV_np_q -> Chunk ;

  refl_SgP1_Chunk,
  refl_SgP2_Chunk,
  refl_SgP3_Chunk,
  refl_PlP1_Chunk,
  refl_PlP2_Chunk,
  refl_PlP3_Chunk : Chunk ;
  neg_Chunk : Chunk ;
  copula_Chunk : Chunk ;
  copula_neg_Chunk : Chunk ;
  copula_inf_Chunk : Chunk ;
  past_copula_Chunk : Chunk ;
  past_copula_neg_Chunk : Chunk ;
  future_Chunk : Chunk ;
  future_neg_Chunk : Chunk ;
  cond_Chunk : Chunk ;
  cond_neg_Chunk : Chunk ;
  perfect_Chunk : Chunk ;
  perfect_neg_Chunk : Chunk ;
  past_perfect_Chunk : Chunk ;
  past_perfect_neg_Chunk : Chunk ;

}
