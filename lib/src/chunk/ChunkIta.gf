concrete ChunkIta of Chunk = CatIta, ExtensionsIta [VPS,VPI] ** 
  ChunkFunctor - [AP_Chunk, SSlash_Chunk]
    with (Syntax = SyntaxIta), (Extensions = ExtensionsIta) **
  open 
    SyntaxIta, (E = ExtensionsIta), Prelude, 
    ResIta, CommonRomance, (P = ParadigmsIta) in {

lin
  AP_Chunk ap = {s = ap.s ! AF (Masc | Fem) (Sg | Pl)} ;

  SSlash_Chunk s = mkUtt <lin S {s = s.s ! {g = Masc ; n = Sg}} : S> ;

lin
  NP_Acc_Chunk np = ss (np.s ! Acc).ton ;
  NP_Gen_Chunk np = ss (np.s ! genitive).comp ;

  VPI_Chunk vpi = vpi ;

oper
  emptyNP = mkNP (P.mkPN []) ;


  copula_inf_Chunk = ss "essere" ;

  refl_SgP1_Chunk = ss "me stesso" ;
  refl_SgP2_Chunk = ss "te stesso" ;
  refl_SgP3_Chunk = ss "lui stesso" ;
  refl_PlP1_Chunk = ss "noi stessi" ;
  refl_PlP2_Chunk = ss "voi stessi" ;
  refl_PlP3_Chunk = ss "loro stessi" ;
  neg_Chunk = ss "non" ;
  copula_Chunk = ss "è" ;
  copula_neg_Chunk = ss "non è" ;
  past_copula_Chunk = ss "era" ;
  past_copula_neg_Chunk = ss "non era" ;
  future_Chunk = ss "vuole"  ; ----
  future_neg_Chunk = ss "non vuole" ; ----
  cond_Chunk = ss "vorrebbe" ; ----
  cond_neg_Chunk = ss "non vorrebbe" ; ----
  perfect_Chunk = ss "ha" ;
  perfect_neg_Chunk = ss "non ha" ;
  past_perfect_Chunk = ss "aveva" ;
  past_perfect_neg_Chunk = ss "non aveva" ;
  
}