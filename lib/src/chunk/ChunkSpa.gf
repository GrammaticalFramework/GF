concrete ChunkSpa of Chunk = CatSpa, ExtensionsSpa [VPS,VPI] ** 
  ChunkFunctor - [AP_Chunk, SSlash_Chunk]
    with (Syntax = SyntaxSpa), (Extensions = ExtensionsSpa) **
  open 
    SyntaxSpa, (E = ExtensionsSpa), Prelude, 
    ResSpa, CommonRomance, (P = ParadigmsSpa) in {

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
  copula_inf_Chunk = ss "ser" | ss "estar" ;

  refl_SgP1_Chunk = ss "yo mismo" ;
  refl_SgP2_Chunk = ss "tu mismo" ;
  refl_SgP3_Chunk = ss "ello mismo" ;
  refl_PlP1_Chunk = ss "nosotros mismos" ;
  refl_PlP2_Chunk = ss "vosotros mismos" ;
  refl_PlP3_Chunk = ss "ellos mismos" ;
  neg_Chunk = ss "no" ;
  copula_Chunk = ss "es" | ss "está" ;
  copula_neg_Chunk = ss "no es" | ss "no está" ;
  past_copula_Chunk = ss "era" ;
  past_copula_neg_Chunk = ss "no era" ;
  future_Chunk = ss "va"  ; ----
  future_neg_Chunk = ss "no va" ; ----
  cond_Chunk = ss "iría" ; ----
  cond_neg_Chunk = ss "no iría" ; ----
  perfect_Chunk = ss "ha" ;
  perfect_neg_Chunk = ss "no ha" ;
  past_perfect_Chunk = ss "había" ;
  past_perfect_neg_Chunk = ss "no había" ;
  
  fullstop_Chunk = ss "." ;
  exclmark_Chunk = ss "!" ;
  questmark_Chunk = ss "?" ;
  comma_Chunk = ss "," ;
  colon_Chunk = ss ":" ;
  semicolon_Chunk = ss ";" ;
  quote_Chunk = ss "\"" ;
  lpar_Chunk = ss "(" ;
  rpar_Chunk = ss ")" ;
  dash_Chunk = ss "-" ;

}