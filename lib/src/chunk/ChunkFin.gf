concrete ChunkFin of Chunk = CatFin, ExtensionsFin [VPS,VPI] ** 
  ChunkFunctor with (Syntax = SyntaxFin), (Extensions = ExtensionsFin) **
  open 
    SyntaxFin, (E = ExtensionsFin), Prelude, 
    ResFin, (P = ParadigmsFin) in {

oper
  emptyNP = mkNP (lin PN {s = \\_ => []}) ;

lin
  NP_Acc_Chunk np = ss (np.s ! NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! NPCase Gen) ;

  VPI_Chunk vpi = {s = vpi.s ! (VVIllat | VVInf)} ;

lin
  copula_inf_Chunk = ss "olla" ;

  refl_SgP1_Chunk = ss "itseni" ;
  refl_SgP2_Chunk = ss "itsesi" ;
  refl_SgP3_Chunk = ss "itse" ;
  refl_PlP1_Chunk = ss "itsemme" ;
  refl_PlP2_Chunk = ss "itsenne" ;
  refl_PlP3_Chunk = ss "itsensä" ;
  neg_Chunk = ss "ei" ;
  copula_Chunk = ss "on" ;
  copula_neg_Chunk = ss "ei ole" ;
  past_copula_Chunk = ss "oli" ;
  past_copula_neg_Chunk = ss "ei ollut" ;
  future_Chunk = ss "tulee" ;
  future_neg_Chunk = ss "ei tule" ;
  cond_Chunk = ss "olisi" ;
  cond_neg_Chunk = ss "ei olisi" ;
  perfect_Chunk = ss "on" ;
  perfect_neg_Chunk = ss "ei ole" ;
  past_perfect_Chunk = ss "oli" ;
  past_perfect_neg_Chunk = ss "ei ollut" ;

}