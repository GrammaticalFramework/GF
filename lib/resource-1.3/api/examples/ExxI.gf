incomplete concrete ExxI of Exx = Cat-[VP], Conjunction-[VP] ** 
  open Lang, Constructors in {

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

    ex1_Det = mkDet (mkQuantSg this_Quant) ;
    ex2_Det = mkDet (mkQuantSg this_Quant) first_Ord ;
    ex3_Det = mkDet (mkQuantPl this_Quant) ;
    ex4_Det = mkDet (mkQuantPl this_Quant) (mkNum n5_Numeral) (mkOrd good_A) ;
    ex5_Det = mkDet this_Quant ;
    ex6_Det = mkDet this_Quant (mkNum n5_Numeral) ;
    ex7_Det = mkDet (mkNum almost_AdN (mkNum n20_Numeral)) ;
    ex8_Det = mkDet n5_Numeral ;
---    ex9_Det = mkDet 51 ;
    ex10_Det = mkDet i_Pron ;
    ex11_Det = defSgDet ;
    ex12_Det = defPlDet ;
    ex13_Det = indefSgDet ;
    ex14_Det = indefPlDet ;

    ex1_Quant = defQuant ;
    ex2_Quant = indefQuant ;

    ex1_QuantSg = mkQuantSg this_Quant ;
    ex2_QuantSg = massQuant ;

    ex1_QuantPl = mkQuantPl this_Quant ;


    ex1_Num = mkNum n20_Numeral ;
---    ex2_Num = mkNum 51 ;
    ex3_Num = mkNum almost_AdN (mkNum n10_Numeral) ;

    ex1_Ord = mkOrd n20_Numeral ;
---    ex2_Ord = mkOrd 51 ;
    ex3_Ord = mkOrd good_A ;

    ex1_AdN = mkAdN more_CAdv ;

    ex1_Numeral = n1_Numeral ;
    ex2_Numeral = n2_Numeral ;
    ex3_Numeral = n3_Numeral ;
    ex4_Numeral = n4_Numeral ;
    ex5_Numeral = n5_Numeral ;
    ex6_Numeral = n6_Numeral ;
    ex7_Numeral = n7_Numeral ;
    ex8_Numeral = n8_Numeral ;
    ex9_Numeral = n9_Numeral ;
    ex10_Numeral = n10_Numeral ;
    ex11_Numeral = n20_Numeral ;
    ex12_Numeral = n100_Numeral ;
    ex13_Numeral = n1000_Numeral ;

    ex1_CN = mkCN house_N ;
    ex2_CN = mkCN mother_N2 john_NP ;
    ex3_CN = mkCN distance_N3 (mkNP (mkDet this_Quant) city_N) (mkNP paris_PN) ;
    ex4_CN = mkCN mother_N2 ;
    ex5_CN = mkCN distance_N3 ;
    ex6_CN = mkCN big_A house_N ;
    ex7_CN = mkCN big_A (mkCN blue_A house_N) ;
    ex8_CN = mkCN (mkAP very_AdA big_A) house_N ;
    ex9_CN = mkCN (mkAP very_AdA big_A) (mkCN blue_A house_N) ;
    ex10_CN = mkCN house_N (mkRS (mkRCl which_RP john_NP love_V2)) ;
    ex11_CN = mkCN (mkCN big_A house_N) (mkRS (mkRCl which_RP john_NP love_V2)) ;
    ex12_CN = mkCN house_N (mkAdv in_Prep (mkNP defSgDet city_N)) ;
    ex13_CN = mkCN (mkCN big_A house_N) (mkAdv in_Prep (mkNP defSgDet city_N)) ;
    ex14_CN = mkCN (mkCN rule_N) (mkS (mkCl john_NP walk_V)) ;
    ex15_CN = mkCN (mkCN question_N) (mkQS (mkCl john_NP walk_V)) ;
    ex16_CN = mkCN (mkCN reason_N) (mkVP walk_V) ;
    ex17_CN = mkCN king_N john_NP ;
    ex18_CN = mkCN (mkCN old_A king_N) john_NP ;

    ex1_AP = mkAP old_A ;
    ex2_AP = mkAP old_A john_NP ;
    ex3_AP = mkAP married_A2 (mkNP she_Pron) ;
    ex4_AP = mkAP married_A2 ;
    ex5_AP = mkAP (mkAP probable_AS) (mkS (mkCl john_NP walk_V)) ;
    ex6_AP = mkAP (mkAP uncertain_A) (mkQS (mkCl john_NP walk_V)) ;
    ex7_AP = mkAP (mkAP ready_A) (mkVP walk_V) ;
    ex8_AP = mkAP very_AdA old_A ;
    ex9_AP = mkAP very_AdA (mkAP very_AdA old_A) ;
    ex10_AP = mkAP and_Conj (mkAP old_A) (mkAP big_A) ;
    ex11_AP = mkAP and_Conj (mkListAP (mkAP old_A) (mkListAP (mkAP big_A) (mkAP warm_A)));
    ex12_AP = mkAP either7or_DConj (mkAP old_A) (mkAP big_A) ;
    ex13_AP = mkAP either7or_DConj (mkListAP (mkAP old_A) (mkListAP (mkAP big_A) (mkAP warm_A)));


    ex1_Adv = mkAdv warm_A ;
    ex2_Adv = mkAdv with_Prep john_NP ;
    ex3_Adv = mkAdv when_Subj (mkS (mkCl john_NP walk_V)) ;
    ex4_Adv = mkAdv more_CAdv warm_A john_NP ;
    ex5_Adv = mkAdv more_CAdv warm_A (mkS (mkCl john_NP walk_V)) ;
    ex6_Adv = mkAdv very_AdA (mkAdv warm_A) ;
    ex7_Adv = mkAdv and_Conj here_Adv now_Adv ;
    ex8_Adv = mkAdv and_Conj (mkListAdv (mkAdv with_Prep john_NP) (mkListAdv here_Adv now_Adv)) ;
    ex9_Adv = mkAdv either7or_DConj here_Adv now_Adv ;
    ex10_Adv = mkAdv either7or_DConj (mkListAdv (mkAdv with_Prep john_NP) (mkListAdv here_Adv now_Adv)) ;



    ex1_QS = mkQS (mkQCl whoSg_IP (mkVP walk_V)) ;
    ex2_QS = mkQS conditionalTense anteriorAnt negativePol (mkQCl whoSg_IP (mkVP walk_V)) ;
    ex3_QS = mkQS (mkCl john_NP walk_V) ;

    ex1_QCl = mkQCl (mkCl john_NP walk_V) ;
    ex2_QCl = mkQCl whoSg_IP (mkVP walk_V) ;
    ex3_QCl = mkQCl whoSg_IP john_NP love_V2 ;
    ex4_QCl = mkQCl whoSg_IP (mkSlash (mkSlash john_NP love_V2) today_Adv) ;
    ex5_QCl = mkQCl why_IAdv (mkCl john_NP walk_V) ;
    ex6_QCl = mkQCl with_Prep whoSg_IP (mkCl john_NP walk_V) ;
    ex7_QCl = mkQCl where_IAdv john_NP ;
    ex8_QCl = mkQCl whatSg_IP ;

    ex1_IP = mkIP whichSg_IDet city_N ;
    ex2_IP = mkIP whichPl_IDet (mkNum n5_Numeral) (mkOrd good_A) (mkCN city_N) ;
    ex3_IP = mkIP whoSg_IP (mkAdv in_Prep (mkNP paris_PN)) ;

    ex1_IAdv = mkIAdv in_Prep (mkIP whichSg_IDet city_N) ;


    ex1_RS = mkRS (mkRCl which_RP (mkVP walk_V)) ;
    ex2_RS = mkRS conditionalTense anteriorAnt negativePol (mkRCl which_RP (mkVP walk_V)) ;

    ex1_RCl = mkRCl which_RP (mkVP walk_V) ;
    ex2_RCl = mkRCl which_RP john_NP love_V2 ;
    ex3_RCl = mkRCl which_RP (mkSlash (mkSlash john_NP love_V2) today_Adv) ;
    ex4_RCl = mkRCl (mkCl john_NP love_V2 (mkNP she_Pron)) ;

    ex1_RP = which_RP ;
    ex2_RP = mkRP in_Prep (mkNP all_Predet (mkNP defPlDet house_N)) which_RP ;

    ex1_Slash = mkSlash john_NP love_V2 ;
    ex2_Slash = mkSlash john_NP want_VV see_V2 ;
    ex3_Slash = mkSlash (mkCl john_NP walk_V) with_Prep ;
    ex4_Slash = mkSlash (mkSlash john_NP love_V2) today_Adv ;


    ex1_ListS = mkListS (mkS (mkCl john_NP walk_V)) (mkS (mkCl (mkNP i_Pron) run_V)) ;
    ex2_ListS = mkListS (mkS (mkCl john_NP walk_V)) (mkListS (mkS (mkCl (mkNP i_Pron) run_V)) (mkS (mkCl (mkNP youSg_Pron) sleep_V))) ;    

    ex1_ListAP = mkListAP (mkAP old_A) (mkAP big_A) ;
    ex2_ListAP = mkListAP (mkAP old_A) (mkListAP (mkAP big_A) (mkAP warm_A)) ;

    ex1_ListAdv = mkListAdv here_Adv now_Adv ;
    ex2_ListAdv = mkListAdv (mkAdv with_Prep john_NP) (mkListAdv here_Adv now_Adv) ;

    ex1_ListNP = mkListNP john_NP (mkNP i_Pron) ;
    ex2_ListNP = mkListNP john_NP (mkListNP (mkNP i_Pron) that_NP) ;



    utt u = mkUtt u ;  -- a hack to linearize VPs

  oper

    john_NP = mkNP john_PN ;
}
