incomplete concrete ExxI of Exx = Cat-[VP] ** open Lang, Constructors in {

-- examples for Constructors.

  lincat VP = Lang.VP ; --- hack to circumvent missing lockfields in overload resolution

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
    ex7_S = mkS today_Adv (mkS futureTense (mkCl john_NP walk_V)) ;

    ex1_Cl = mkCl john_NP walk_V ;
    ex2_Cl = mkCl john_NP love_V2 (mkNP she_Pron) ;
    ex3_Cl = mkCl john_NP send_V3 (mkNP it_Pron) (mkNP she_Pron) ;
    ex4_Cl = mkCl john_NP want_VV (mkVP walk_V) ;
    ex5_Cl = mkCl john_NP say_VS (mkS (mkCl (mkNP it_Pron) good_A)) ;
    ex6_Cl = mkCl john_NP wonder_VQ (mkQS (mkCl (mkNP it_Pron) good_A)) ;
    ex7_Cl = mkCl john_NP become_VA (mkAP old_A) ;
    ex8_Cl = mkCl john_NP paint_V2A (mkNP it_Pron) (mkAP red_A) ;
    ex9_Cl = mkCl john_NP old_A ;
    ex10_Cl = mkCl john_NP old_A (mkNP she_Pron) ;
    ex11_Cl = mkCl john_NP married_A2 (mkNP she_Pron) ;
    ex12_Cl = mkCl john_NP (mkAP very_AdA (mkAP old_A)) ;
    ex13_Cl = mkCl john_NP man_N ;
    ex14_Cl = mkCl john_NP (mkCN old_A man_N) ;
    ex15_Cl = mkCl john_NP (mkNP defSgDet man_N) ;
    ex16_Cl = mkCl john_NP here_Adv ;
    ex17_Cl = mkCl john_NP (mkVP (mkVP walk_V) here_Adv) ;
    ex18_Cl = mkCl rain_V0 ;
    ex19_Cl = mkCl (progressiveVP (mkVP rain_V0)) ;
    ex20_Cl = mkCl house_N ;
    ex21_Cl = mkCl (mkCN old_A house_N) ;
    ex22_Cl = mkCl (mkNP n5_Numeral house_N) ;
    ex23_Cl = mkCl john_NP (mkRS (mkRCl which_RP (mkVP walk_V))) ;
    ex24_Cl = mkCl here_Adv (mkS (mkCl john_NP walk_V)) ;
    ex25_Cl = mkCl (mkVP walk_V) ;

    ex1_VP = mkVP walk_V ;
    ex2_VP = mkVP love_V2 (mkNP she_Pron) ;
    ex3_VP = mkVP send_V3 (mkNP it_Pron) (mkNP she_Pron) ;
    ex4_VP = mkVP want_VV (mkVP walk_V) ;
    ex5_VP = mkVP say_VS (mkS (mkCl (mkNP it_Pron) good_A)) ;
    ex6_VP = mkVP wonder_VQ (mkQS (mkCl (mkNP it_Pron) good_A)) ;
    ex7_VP = mkVP become_VA (mkAP old_A) ;
    ex8_VP = mkVP paint_V2A (mkNP it_Pron) (mkAP red_A) ;

    ex9_VP = mkVP old_A ;
    ex10_VP = mkVP old_A (mkNP she_Pron) ;
    ex11_VP = mkVP married_A2 (mkNP she_Pron) ;
    ex12_VP = mkVP (mkAP very_AdA (mkAP old_A)) ;

    ex13_VP = mkVP man_N ;
    ex14_VP = mkVP (mkCN old_A man_N) ;
    ex15_VP = mkVP (mkNP defSgDet man_N) ;
    ex16_VP = mkVP here_Adv ;
    ex17_VP = mkVP (mkVP sleep_V) here_Adv ;
    ex18_VP = mkVP always_AdV (mkVP sleep_V) ;
    ex19_VP = reflexiveVP love_V2 ;
    ex20_VP = passiveVP love_V2 ;
    ex21_VP = passiveVP love_V2 (mkNP she_Pron) ;
    ex22_VP = progressiveVP (mkVP sleep_V) ;

    ex1_NP = mkNP (mkDet (mkQuantSg defQuant) first_Ord) man_N ;
    ex2_NP = mkNP (mkDet (mkQuantSg defQuant) first_Ord) (mkCN old_A man_N) ;
    ex3_NP = mkNP (mkQuantSg this_Quant) man_N ;
    ex4_NP = mkNP (mkQuantSg this_Quant) (mkCN old_A man_N) ;
    ex5_NP = mkNP (mkQuantPl this_Quant) man_N ;
    ex6_NP = mkNP (mkQuantPl this_Quant) (mkCN old_A man_N) ;
    ex7_NP = mkNP n20_Numeral man_N ;
    ex8_NP = mkNP n20_Numeral (mkCN old_A man_N) ;
---    ex9_NP = mkNP (mkInt "45") man_N ;
---    ex10_NP = mkNP (mkInt "45") (mkCN old_A man_N) ;
    ex11_NP = mkNP (mkNum almost_AdN (mkNum n20_Numeral)) man_N ;
    ex12_NP = mkNP (mkNum almost_AdN (mkNum n20_Numeral)) (mkCN old_A man_N) ;
    ex13_NP = mkNP i_Pron man_N ;
    ex14_NP = mkNP i_Pron (mkCN old_A man_N) ;
    ex15_NP = mkNP john_PN ;
    ex16_NP = mkNP i_Pron ;
    ex17_NP = mkNP only_Predet john_NP ;
    ex18_NP = mkNP john_NP kill_V2 ;
    ex19_NP = mkNP john_NP (mkAdv in_Prep (mkNP paris_PN)) ;
    ex20_NP = mkNP and_Conj john_NP (mkNP i_Pron) ;
    ex21_NP = mkNP and_Conj (mkListNP john_NP (mkListNP (mkNP i_Pron) that_NP)) ;
    ex22_NP = mkNP either7or_DConj john_NP (mkNP i_Pron) ;
    ex23_NP = mkNP either7or_DConj (mkListNP john_NP (mkListNP (mkNP i_Pron) that_NP)) ;



    utt u = mkUtt u ;  -- a hack to linearize VPs

  oper
    john_PN = paris_PN ; ----
    today_Adv = here_Adv ; ----

    john_NP = mkNP john_PN ;
}
