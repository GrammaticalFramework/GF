concrete ChunkEst of Chunk = CatEst, ExtensionsEst [VPS,VPI] ** 
  ChunkFunctor - [Prep_Chunk] with (Syntax = SyntaxEst), (Extensions = ExtensionsEst) **
  open 
    SyntaxEst, (E = ExtensionsEst), Prelude, 
    ResEst, (P = ParadigmsEst) in {

oper
  emptyNP = mkNP (lin PN {s = \\_ => []}) ;

-- overridden, to avoid the generation of dangling case endings
lin
  Prep_Chunk prep = mkAdv prep something_NP ;

lin
  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! NPCase Gen) ;

----  VPI_Chunk vpi = {s = vpi.s ! (VVIllat | VVInf)} ;

lin
  copula_inf_Chunk = ss "olla" ;

  refl_SgP1_Chunk = ss "ise" ;
  refl_SgP2_Chunk = ss "ise" ;
  refl_SgP3_Chunk = ss "ise" ;
  refl_PlP1_Chunk = ss "ise" ;
  refl_PlP2_Chunk = ss "ise" ;
  refl_PlP3_Chunk = ss "ise" ;
  neg_Chunk = ss "ei" ;
  copula_Chunk = ss "on" ;
  copula_neg_Chunk = ss "ei ole" ;
  past_copula_Chunk = ss "oli" ;
  past_copula_neg_Chunk = ss "ei olnud" ;
  future_Chunk = ss "tuleb" ;
  future_neg_Chunk = ss "ei tule" ;
  cond_Chunk = ss "oleks" ;
  cond_neg_Chunk = ss "ei oleks" ;
  perfect_Chunk = ss "on" ;
  perfect_neg_Chunk = ss "ei ole" ;
  past_perfect_Chunk = ss "oli" ;
  past_perfect_neg_Chunk = ss "ei olnud" ;

}