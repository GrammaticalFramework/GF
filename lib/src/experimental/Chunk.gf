abstract Chunk = RGLBase - [Pol,Tense], NDPred ** {

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
  Cl_np_Chunk : PrCl_np -> Chunk ;
  QCl_Chunk : PrQCl_none -> Chunk ;
  QCl_np_Chunk : PrQCl_np -> Chunk ;
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