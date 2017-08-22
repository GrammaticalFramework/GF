--# -path=.:alltenses

concrete LibraryBrowserEng of LibraryBrowser = 
  GrammarEng - [
---    n2,n3,n4,n5,n6,n7,n8,D_0,D_1,D_2,D_3,D_4,D_5,D_6,D_7,D_8,
    UseCopula
---    ,UsePron, IndefArt, DefArt, Use2N3, Use3N3
    ], 
  LexiconEng
{-
  [
    N,   man_N, woman_N, house_N,
    N2,  brother_N2,
    N3,  distance_N3,
    PN,  john_PN, paris_PN,
    A,   old_A, young_A, red_A,
    A2,  married_A2,
    V,   sleep_V, walk_V,
    V2,  love_V2,
    V3,  give_V3,
    VA,  become_VA, 
    VS,  know_VS,
    VQ,  wonder_VQ,
    V2V, beg_V2V,
    V2A, paint_V2A,
    V2S, answer_V2S,
    V2Q, ask_V2Q
    ]
-}
  ** open (S = SyntaxEng) in {
  
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

