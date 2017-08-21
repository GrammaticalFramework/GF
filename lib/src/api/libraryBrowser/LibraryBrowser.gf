abstract LibraryBrowser = 
  Grammar - [
--    n2,n3,n4,n5,n6,n7,n8,D_0,D_1,D_2,D_3,D_4,D_5,D_6,D_7,D_8,
    UseCopula
--    ,UsePron, IndefArt, DefArt, Use2N3, Use3N3
    ], 
  Lexicon
{- AR 21/8/2017 removing almost all the restrictions
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
  ** {
  flags startcat = Utt ;

  fun
    i_NP, you_NP, he_NP, she_NP, we_NP, youPl_NP, youPol_NP, they_NP : NP ;
    a_Det, the_Det, aPl_Det, thePl_Det : Det ;

}
