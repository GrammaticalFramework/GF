concrete ChunkCat of Chunk = CatCat, ExtensionsCat [VPS,VPI] ** 
  ChunkFunctor - [AP_Chunk, SSlash_Chunk]
    with (Syntax = SyntaxCat), (Extensions = ExtensionsCat) **
  open 
    SyntaxCat, (E = ExtensionsCat), Prelude, 
    ResCat, CommonRomance, (P = ParadigmsCat) in {

lin
  AP_Chunk ap = {s = ap.s ! AF (Masc | Fem) (Sg | Pl)} ;

  SSlash_Chunk s = mkUtt <lin S {s = s.s ! {g = Masc ; n = Sg}} : S> ;

lin
  NP_Acc_Chunk np = ss (np.s ! Acc).ton ;
  NP_Gen_Chunk np = ss (np.s ! genitive).comp ;

  VPI_Chunk vpi = vpi ;

oper
  emptyNP = mkNP (P.mkPN []) ;

lin
  copula_inf_Chunk = ss "ser" ;

  refl_SgP1_Chunk = ss "jo mateix" ;
  refl_SgP2_Chunk = ss "tu mateix" ; 
  refl_SgP3_Chunk = ss "aquell mateix" ;
  refl_PlP1_Chunk = ss "nosaltres mateixos" ;
  refl_PlP2_Chunk = ss "vosaltres mateixos" ;
  refl_PlP3_Chunk = ss "ells mateixos" ;
  neg_Chunk = ss "no" ;
  copula_Chunk = ss "és" ;
  copula_neg_Chunk = ss "no és" ;
  past_copula_Chunk = ss "va ser" ;
  past_copula_neg_Chunk = ss "no va ser" ;
  future_Chunk = ss "va"  ; ----
  future_neg_Chunk = ss "no va" ; ----
  cond_Chunk = ss "aniria" ; ----
  cond_neg_Chunk = ss "no aniria" ; ----
  perfect_Chunk = ss "ha" ;
  perfect_neg_Chunk = ss "no ha" ;
  past_perfect_Chunk = ss "havia" ;
  past_perfect_neg_Chunk = ss "no havia" ;

}
