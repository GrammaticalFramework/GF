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
  CN_Pl_Chunk : CN -> Chunk ;
  CN_Sg_Chunk : CN -> Chunk ;
  CN_Pl_Gen_Chunk : CN -> Chunk ;
  CN_Sg_Gen_Chunk : CN -> Chunk ;
  Conj_Chunk : Conj -> Chunk ;
  IAdv_Chunk : IAdv -> Chunk ;
  IP_Chunk : IP -> Chunk ;
  NP_Chunk : NP -> Chunk ;
  NP_Gen_Chunk : NP -> Chunk ;
  Numeral_Chunk : Numeral -> Chunk ;
  Ord_Chunk : Ord -> Chunk ;
  Predet_Chunk : Predet -> Chunk ;
  Prep_Chunk : Prep -> Chunk ;
  RP_Chunk : RP -> Chunk ;
  Subj_Chunk : Subj -> Chunk ;
  VP_Chunk : VP -> Chunk ;
  VP_np_Chunk : PrVP_np -> Chunk ;
  VP_none_Chunk : PrVP_none -> Chunk ;
  VP_s_Chunk : PrVP_s -> Chunk ;

  neg_Chunk : Chunk ;
  copula_Chunk : Chunk ;
  past_copula_Chunk : Chunk ;
  future_Chunk : Chunk ;
  cond_Chunk : Chunk ;
  perfect_Chunk : Chunk ;
  past_perfect_Chunk : Chunk ;

}