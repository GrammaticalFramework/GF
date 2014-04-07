concrete ChunkChi of Chunk = CatChi, ExtensionsChi [VPS,VPI] ** 
  ChunkFunctor - [Numeral_Nom_Chunk, Conj_Chunk, CN_Pl_Chunk, Subj_Chunk, emptyNP, Prep_Chunk, Predet_Chunk]
     with (Syntax = SyntaxChi), (Extensions = ExtensionsChi) **
  open 
    SyntaxChi, (E = ExtensionsChi), Prelude, 
    ResChi, (P = ParadigmsChi) in {

oper
  emptyNP : NP = mkNP [] ;

-- exceptions to functor

lin
  Conj_Chunk conj = ss (conj.s ! CSent).s2 ;
  Numeral_Nom_Chunk num = ss (num.s ++ ge_s) ;
  CN_Pl_Chunk cn = cn ;
  Subj_Chunk subj = ss (subj.prePart ++ subj.sufPart) ;
  Prep_Chunk prep = ss (prep.prepPre ++ prep.prepPost) ;
  Predet_Chunk predet = predet ;



lin
  NP_Acc_Chunk np = np ;
  NP_Gen_Chunk np = ss (np.s ++ de_s) ;

  VPI_Chunk vpi = vpi ;

  copula_inf_Chunk = ss copula_s ;

  refl_SgP1_Chunk = ss reflPron ;
  refl_SgP2_Chunk = ss reflPron ;
  refl_SgP3_Chunk = ss reflPron ;
  refl_PlP1_Chunk = ss reflPron ;
  refl_PlP2_Chunk = ss reflPron ;
  refl_PlP3_Chunk = ss reflPron ;
  neg_Chunk = ss neg_s ;
  copula_Chunk = ss copula_s ;
  copula_neg_Chunk = ss (neg_s ++ copula_s) ;
  past_copula_Chunk = ss "了" ;
  past_copula_neg_Chunk = ss (neg_s ++ copula_s ++ "了") ;
  future_Chunk = ss copula_s ; ----
  future_neg_Chunk = ss (neg_s ++ copula_s) ;
  cond_Chunk = ss copula_s ; ----
  cond_neg_Chunk = ss (neg_s ++ copula_s) ;
  perfect_Chunk = ss "了" ;
  perfect_neg_Chunk = ss (neg_s ++ copula_s ++ "了") ;
  past_perfect_Chunk = ss "了" ;
  past_perfect_neg_Chunk = ss (neg_s ++ copula_s ++ "了") ;



}