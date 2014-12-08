concrete ChunkFre of Chunk = CatFre, ExtensionsFre [VPS,VPI] ** 
  ChunkFunctor - [AP_Chunk, SSlash_Chunk]
    with (Syntax = SyntaxFre), (Extensions = ExtensionsFre) **
  open 
    SyntaxFre, (E = ExtensionsFre), Prelude, 
    ResFre, PhonoFre, CommonRomance, (P = ParadigmsFre) in {

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
  copula_inf_Chunk = ss "être" ;

  refl_SgP1_Chunk = ss "moi-même" ;
  refl_SgP2_Chunk = ss "toi-même" ;
  refl_SgP3_Chunk = ss "lui-même" ;
  refl_PlP1_Chunk = ss "nous-mêmes" ;
  refl_PlP2_Chunk = ss "vous-mêmes" ;
  refl_PlP3_Chunk = ss "eux-mêmes" ;
  neg_Chunk = ss "non" ;
  copula_Chunk = ss "est" ;
  copula_neg_Chunk = ss "n'est pas" ;
  past_copula_Chunk = ss "était" ;
  past_copula_neg_Chunk = ss "n'était pas" ;
  future_Chunk = ss "va"  ;
  future_neg_Chunk = ss "ne va pas" ;
  cond_Chunk = ss "ferait" ; ----
  cond_neg_Chunk = ss "ne ferait pas" ; ----
  perfect_Chunk = ss "a" ;
  perfect_neg_Chunk = ss "n'a pas" ;
  past_perfect_Chunk = ss "avait" ;
  past_perfect_neg_Chunk = ss "n'avait pas" ;

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