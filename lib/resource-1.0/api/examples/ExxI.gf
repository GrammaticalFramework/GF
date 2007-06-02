incomplete concrete ExxI of Exx = Cat ** open Lang, Constructors in {

-- examples for Constructors.

  lin
    ex1_Text = mkText (mkPhr but_PConj (mkUtt (mkCl john_NP walk_V))) ;
    ex2_Text = mkText (mkPhr (mkCl john_NP walk_V)) questMarkPunct (mkText yes_Phr) ;
    ex3_Text = mkText (mkUtt john_NP) ;
    ex4_Text = mkText (mkS pastTense (mkCl john_NP walk_V)) ;
    ex5_Text = mkText (mkCl john_NP walk_V) ;
    ex6_Text = mkText (mkQS pastTense (mkQCl (mkCl john_NP walk_V))) ;
    ex7_Text = mkText (mkImp walk_V) ;
    ex8_Text = emptyText ;

    ex1_Phr = mkPhr (mkUtt why_IAdv) ;
    ex2_Phr = mkPhr but_PConj (mkUtt why_IAdv) (mkVoc john_NP) ;
    ex3_Phr = mkPhr (mkS pastTense (mkCl john_NP walk_V)) ;
    ex4_Phr = mkPhr (mkCl john_NP walk_V) ;
    ex5_Phr = mkPhr (mkQS pastTense (mkQCl (mkCl john_NP walk_V))) ;
    ex6_Phr = mkPhr (mkImp walk_V) ;

    ex1_PConj = mkPConj and_Conj ;

    ex1_Voc = mkVoc john_NP ;

    ex1_Utt = mkUtt (mkS pastTense (mkCl john_NP walk_V)) ;
    ex2_Utt = mkUtt (mkCl john_NP walk_V) ;
    ex3_Utt = mkUtt (mkQS pastTense (mkQCl (mkCl john_NP walk_V))) ;
    ex4_Utt = mkUtt (mkImp walk_V) ;
    ex5_Utt = mkUtt pluralImpForm negativePol (mkImp (reflexiveVP love_V2)) ;
    ex6_Utt = mkUtt whoSg_IP ;
    ex7_Utt = mkUtt why_IAdv ;
    ex8_Utt = mkUtt john_NP ;
    ex9_Utt = mkUtt here_Adv ;
    ex10_Utt = mkUtt (mkVP walk_V) ;
    ex11_Utt = lets_Utt (mkVP walk_V) ;

    ex1_S = mkS (mkCl john_NP walk_V) ;
    ex2_S = mkS conditionalTense anteriorAnt negativePol (mkCl john_NP walk_V) ;
    ex3_S = mkS and_Conj (mkS (mkCl john_NP walk_V)) (mkS (mkCl (mkNP i_Pron) run_V)) ;
    ex4_S = mkS and_Conj (mkListS (mkS (mkCl john_NP walk_V)) (mkListS (mkS (mkCl (mkNP i_Pron) run_V)) (mkS (mkCl (mkNP youSg_Pron) sleep_V)))) ;
    ex5_S = mkS either7or_DConj (mkS (mkCl john_NP walk_V)) (mkS (mkCl (mkNP i_Pron) run_V)) ;
    ex6_S = mkS either7or_DConj (mkListS (mkS (mkCl john_NP walk_V)) (mkListS (mkS (mkCl (mkNP i_Pron) run_V)) (mkS (mkCl (mkNP youSg_Pron) sleep_V)))) ;



  oper
    john_PN = paris_PN ; ----
    john_NP = mkNP john_PN ;
}
