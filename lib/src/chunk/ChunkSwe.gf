concrete ChunkSwe of Chunk = CatSwe, ExtensionsSwe [VPS,VPI] ** 
  ChunkFunctor with (Syntax = SyntaxSwe), (Extensions = ExtensionsSwe) **
  open 
    SyntaxSwe, (E = ExtensionsSwe), Prelude, 
    (C=CommonScand), (R=ResSwe), (P = ParadigmsSwe) in {

lin
  NP_Acc_Chunk np = ss (np.s ! C.NPAcc) ;
  NP_Gen_Chunk np = ss (np.s ! C.NPPoss (C.GSg C.Utr) C.Nom) ;

  VPI_Chunk vpi = {s = optStr "att" ++ vpi.s ! R.VPIInf ! R.agrP3 (C.Utr | C.Neutr) C.Sg} ;

oper
  emptyNP = mkNP (P.mkPN []) ;

lin
  copula_inf_Chunk = ss "att vara" | ss "vara" ;
  refl_SgP1_Chunk = ss "mig själv" ;
  refl_SgP2_Chunk = ss "dig själv" ;
  refl_SgP3_Chunk = ss "sig själv" ;
  refl_PlP1_Chunk = ss "oss själva" ;
  refl_PlP2_Chunk = ss "er själva" ;
  refl_PlP3_Chunk = ss "sig själva" ;
  neg_Chunk = ss "inte" ;
  copula_Chunk = ss "är" ;
  copula_neg_Chunk = ss "är inte" ;
  past_copula_Chunk = ss "var" ;
  past_copula_neg_Chunk = ss "var inte" ;
  future_Chunk = ss "ska" | ss "skall" ;
  future_neg_Chunk = ss "ska inte" | ss "skall inte" ;
  cond_Chunk = ss "skulle" ;
  cond_neg_Chunk = ss "skulle inte" ;
  perfect_Chunk = ss "har" ;
  perfect_neg_Chunk = ss "har inte" ;
  past_perfect_Chunk = ss "hade" ;
  past_perfect_neg_Chunk = ss "hade inte" ;

}