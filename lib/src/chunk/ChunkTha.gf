concrete ChunkTha of Chunk = CatTha, ExtensionsTha [VPS,VPI] ** 
  ChunkFunctor -- - [Numeral_Nom_Chunk, Conj_Chunk, CN_Pl_Chunk, Subj_Chunk, emptyNP, Prep_Chunk, Predet_Chunk]
     with (Syntax = SyntaxTha), (Extensions = ExtensionsTha) **
  open 
    SyntaxTha, (E = ExtensionsTha), Prelude, 
    ResTha, (P = ParadigmsTha), StringsTha in {

oper
  emptyNP : NP = mkNP [] ;

{-
-- exceptions to functor ONLY IF NEEDED

lin
  Conj_Chunk conj = ss (conj.s ! CSent).s2 ;
  Numeral_Nom_Chunk num = ss (num.s ++ ge_s) ;
  CN_Pl_Chunk cn = cn ;
  Subj_Chunk subj = ss (subj.prePart ++ subj.sufPart) ;
  Prep_Chunk prep = ss (prep.prepPre ++ prep.prepPost) ;
  Predet_Chunk predet = predet ;
-}

-- THESE ARE NEEDED
lin
  NP_Acc_Chunk np = np ;
  NP_Gen_Chunk np = ss (khoog_s ++ np.s) ;

  VPI_Chunk vpi = vpi ;

  copula_inf_Chunk = ss pen_s ;

  refl_SgP1_Chunk = ss reflPron ;
  refl_SgP2_Chunk = ss reflPron ;
  refl_SgP3_Chunk = ss reflPron ;
  refl_PlP1_Chunk = ss reflPron ;
  refl_PlP2_Chunk = ss reflPron ;
  refl_PlP3_Chunk = ss reflPron ;
  neg_Chunk = ss may_s ;
  copula_Chunk = ss pen_s ;
  copula_neg_Chunk = ss (thbind may_s chay_s) ;
{- ---- TODO
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
-}

}