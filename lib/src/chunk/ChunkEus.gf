

concrete ChunkEus of Chunk = CatEus, SymbolEus [Symb], ExtensionsEus [VPS,VPI] ** 
  ChunkFunctor - [Det_Chunk]
    with (Syntax = SyntaxEus), (Extensions = ExtensionsEus) **
  open 
    Prelude, (R = ResEus), (P=ParadigmsEus), (E=ExtensionsEus) in {

lin


  NP_Acc_Chunk np = ss (np.s ! R.Abs) ; -- lol I'm ergative-absolutive 
  NP_Gen_Chunk np = ss (np.s ! R.Gen) ;

  VPI_Chunk vpi = vpi ; ----

oper
  empty_NP : NP = lin NP R.empty_NP ;

lin
 --TODO: these are just Google translate / my wild guesses
  copula_inf_Chunk = ss "izan" | ss "izaten" ;
  refl_SgP1_Chunk = ss "neuk" ;
  refl_SgP2_Chunk = ss "zeuk" | ss "heuk" ;
  refl_SgP3_Chunk = ss "berau" ;
  refl_PlP1_Chunk = ss "geuk" ;
  refl_PlP2_Chunk = ss "zeuek" ;
  refl_PlP3_Chunk = ss "beraiek " ;
  neg_Chunk = ss "not" | ss "doesn't" | ss "don't" ;
  copula_Chunk = ss "naiz" | ss "zara" | ss "da" | ss "gara" | ss "zarete" | ss "dira" ; 
  copula_neg_Chunk = ss "ez naiz" | ss "ez zara" | ss "ez da" | ss "ez gara" | ss "ez zarete" | ss "ez dira"  ;
  past_copula_Chunk = ss "zen" ;
  past_copula_neg_Chunk = ss "ez zen" ;
  future_Chunk = ss "izango" ;
  future_neg_Chunk = ss "ez izango" ;
  cond_Chunk = ss "litzateke" ;
  cond_neg_Chunk = ss "ez litzateke" ;
  perfect_Chunk = ss "izan" ;
  perfect_neg_Chunk = ss "ez izan" ;
  past_perfect_Chunk = ss "zen" ;
  past_perfect_neg_Chunk = ss "ez zen" ;
  

}