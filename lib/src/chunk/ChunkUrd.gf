concrete ChunkUrd of Chunk = CatUrd, ExtensionsUrd [VPS,VPI] ** 
  ChunkFunctor - [Adv_Chunk, Prep_Chunk]
    with (Syntax = SyntaxUrd), (Extensions = ExtensionsUrd) **
  open 
    SyntaxUrd, (E = ExtensionsUrd), Prelude, CommonHindustani, 
    (R = ResUrd), (P = ParadigmsUrd) in {

lin
  Adv_Chunk adv = mkUtt adv ;
  Prep_Chunk prep = pss (prep.s ! Masc) ; ----

oper
  emptyNP = mkNP (P.mkPN []) ;
  pss = Prelude.ss ;

lin
  NP_Acc_Chunk np = mkUtt np ;
  NP_Gen_Chunk np = mkUtt (mkAdv possess_Prep np) ;

----  VPI_Chunk vpi = vpi ;

  copula_inf_Chunk = pss " है " ;

  refl_SgP1_Chunk,
  refl_SgP2_Chunk,
  refl_SgP3_Chunk,
  refl_PlP1_Chunk,
  refl_PlP2_Chunk,
  refl_PlP3_Chunk = pss " आप " ; ----

  neg_Chunk = pss " नहीं " ;
  copula_Chunk = pss " है " ;
  copula_neg_Chunk = pss " नहीं है " ;

  past_copula_Chunk = pss " था " ;
  past_copula_neg_Chunk = pss " नहीं था " ;

  future_Chunk = pss " हीं होगा " ;
  future_neg_Chunk = pss " नहीं होगा " ;

  cond_Chunk = pss " हीं होगा " ; ---- same as future
  cond_neg_Chunk = pss " नहीं होगा " ;
  perfect_Chunk = pss " है " ;
  perfect_neg_Chunk = pss " नहीं " ;
  past_perfect_Chunk = pss " था " ;
  past_perfect_neg_Chunk = pss " नहीं " ;

}