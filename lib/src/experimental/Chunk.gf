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
  VP_np_Chunk : PrVP_np -> Chunk ;
  VP_none_Chunk : PrVP_none -> Chunk ;
  VP_s_Chunk : PrVP_s -> Chunk ;
  VP_v_Chunk : PrVP_v -> Chunk ;

  refl_SgP3_Chunk : Chunk ;
  neg_Chunk : Chunk ;
  copula_Chunk : Chunk ;
  copula_neg_Chunk : Chunk ;
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