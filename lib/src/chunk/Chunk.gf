abstract Chunk = Cat, Symbol [Symb], Extensions [VPS,VPI] ** {

cat
  Chunks ;
  Chunk ;

  VC ;

fun
  OneChunk : Chunk -> Chunks ;
  PlusChunk : Chunk -> Chunks -> Chunks ;

  ChunkPhr : Chunks -> Phr ;

fun

  AP_Chunk  : AP  -> Chunk ;
  AdA_Chunk : AdA -> Chunk ;
  Adv_Chunk : Adv -> Chunk ;
  AdV_Chunk : AdV -> Chunk ;
  AdN_Chunk : AdN -> Chunk ;
  S_Chunk      : S   -> Chunk ;
  SSlash_Chunk : SSlash -> Chunk ;
  QS_Chunk     : QS  -> Chunk ;
  CN_Pl_Chunk  : CN -> Chunk ;
  CN_Sg_Chunk  : CN -> Chunk ;
  CN_Pl_Gen_Chunk : CN -> Chunk ;
  CN_Sg_Gen_Chunk : CN -> Chunk ;
  Conj_Chunk : Conj -> Chunk ;
  Det_Chunk : Det -> Chunk ; -- needed if article form is different from NP form, e.g. English a/an
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
  Prep_Chunk   : Prep -> Chunk ;
  RP_Nom_Chunk : RP -> Chunk ;
  RP_Gen_Chunk : RP -> Chunk ;
  RP_Acc_Chunk : RP -> Chunk ;
  Subj_Chunk   : Subj -> Chunk ;
--- PConj_Chunk  : PConj -> Chunk ;

  VPS_Chunk    : VPS -> Chunk ;
  VPI_Chunk    : VPI -> Chunk ;

-- verbs lifted to one cat

  V2_V   : V2  -> VC ; 
  VA_V   : VA  -> VC ; 
  VQ_V   : VQ  -> VC ; 
  VS_V   : VS  -> VC ; 
  VV_V   : VV  -> VC ; 

  V3_V   : V3  -> VC ; 
  V2A_V  : V2A -> VC ; 
  V2Q_V  : V2Q -> VC ; 
  V2S_V  : V2S -> VC ; 
  V2V_V  : V2V -> VC ; 

  UseVC  : Temp -> Pol -> VC -> VPS ;

-- for unknown words that are not names

  Symb_Chunk : Symb -> Chunk ;

-- syncategorematic chunks
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

-- chunks for punctuation marks
  fullstop_Chunk : Chunk ;
  exclmark_Chunk : Chunk ;
  questmark_Chunk : Chunk ;
  comma_Chunk : Chunk ;
  colon_Chunk : Chunk ;
  semicolon_Chunk : Chunk ;
  quote_Chunk : Chunk ;
  lpar_Chunk : Chunk ;
  rpar_Chunk : Chunk ;
  dash_Chunk : Chunk ;

}