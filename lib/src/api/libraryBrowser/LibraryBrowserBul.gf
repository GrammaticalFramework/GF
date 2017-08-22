--# -path=.:alltenses

concrete LibraryBrowserBul of LibraryBrowser = 
  GrammarBul - [
    UseCopula
    ], 
  LexiconBul
    ** open (S = SyntaxBul) in {

  lin
    i_NP = S.i_NP ;
    you_NP = S.you_NP ;
    he_NP = S.he_NP ;
    she_NP = S.she_NP ;
    we_NP = S.we_NP ;
    youPl_NP = S.youPl_NP ;
    youPol_NP = S.youPol_NP ;
    they_NP = S.they_NP ;

    a_Det = S.mkDet S.a_Quant ;
    the_Det = S.mkDet S.the_Quant ;
    aPl_Det = S.mkDet S.a_Quant S.plNum ;
    thePl_Det = S.mkDet S.the_Quant S.plNum ;
}

