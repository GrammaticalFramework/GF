concrete ChunkGer of Chunk = CatGer, ExtensionsGer [VPS,VPI] ** 
  ChunkFunctor with (Syntax = SyntaxGer), (Extensions = ExtensionsGer) **
  open 
    SyntaxGer, (E = ExtensionsGer), Prelude, 
    ResGer, (P = ParadigmsGer) in {

oper
  emptyNP = mkNP (P.mkPN []) ;

lin
  NP_Acc_Chunk np = ss (np.s ! NPC Acc ++ bigNP np) ;
  NP_Gen_Chunk np = ss (np.s ! NPC Gen ++ bigNP np) ;

  VPI_Chunk vpi = {s = vpi.s ! (True | False)} ;

lin
  copula_inf_Chunk = ss "sein" ;

  refl_SgP1_Chunk = ss "mich selbst" ;
  refl_SgP2_Chunk = ss "dich selbst" ;
  refl_SgP3_Chunk = ss "sich selbst" ;
  refl_PlP1_Chunk = ss "uns selbst" ;
  refl_PlP2_Chunk = ss "euch selbst" ;
  refl_PlP3_Chunk = ss "sich selbst" ;
  neg_Chunk = ss "nicht" ;
  copula_Chunk = ss "ist" ;
  copula_neg_Chunk = ss "ist nicht" ;
  past_copula_Chunk = ss "war" ;
  past_copula_neg_Chunk = ss "war nicht" ;
  future_Chunk = ss "wird"  ;
  future_neg_Chunk = ss "wird nicht" ;
  cond_Chunk = ss "würde" ;
  cond_neg_Chunk = ss "würde nicht" ;
  perfect_Chunk = ss "hat" ;
  perfect_neg_Chunk = ss "hat nicht" ;
  past_perfect_Chunk = ss "hatte" ;
  past_perfect_neg_Chunk = ss "hatte nicht" ;

}