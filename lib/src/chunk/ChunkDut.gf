concrete ChunkDut of Chunk = CatDut, ExtensionsDut [VPS,VPI]
 ** 
  ChunkFunctor - [emptyNP]
    with (Syntax = SyntaxDut), (Extensions = ExtensionsDut) 
    **
  open 
    SyntaxDut, (E = ExtensionsDut), Prelude, 
    ResDut, (P = ParadigmsDut) in {

 oper
  emptyNP = SyntaxDut.mkNP (P.mkPN []) ;

lin
  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss ("van" ++ np.s ! NPAcc) ; ----

  VPI_Chunk vpi = {s = vpi.s ! (True | False)} ;

lin
  copula_inf_Chunk = ss "zijn" ;

  refl_SgP1_Chunk = ss "mij zelf" ;
  refl_SgP2_Chunk = ss "jij zelf" ;
  refl_SgP3_Chunk = ss "zij zelf" ;
  refl_PlP1_Chunk = ss "ons zelf" ;
  refl_PlP2_Chunk = ss "jullie zelf" ;
  refl_PlP3_Chunk = ss "zij zelf" ;
  neg_Chunk = ss "niet" ;
  copula_Chunk = ss "is" ;
  copula_neg_Chunk = ss "is niet" ;
  past_copula_Chunk = ss "was" ;
  past_copula_neg_Chunk = ss "was niet" ;
  future_Chunk = ss "zal"  ;
  future_neg_Chunk = ss "zal niet" ;
  cond_Chunk = ss "zou" ;
  cond_neg_Chunk = ss "zou niet" ;
  perfect_Chunk = ss "heeft" ;
  perfect_neg_Chunk = ss "heeft niet" ;
  past_perfect_Chunk = ss "had" ;
  past_perfect_neg_Chunk = ss "had niet" ;

}