abstract Exx = Cat-[VP], Conjunction-[VP] ** {

cat VP ; --- hack to circumvent missing lockfields in overload resolution

fun

  ex1_Text, ex2_Text, ex3_Text, ex4_Text, ex5_Text, ex6_Text, ex7_Text, 
  ex8_Text : Text ;

  ex1_Phr, ex2_Phr, ex3_Phr, ex4_Phr, ex5_Phr, ex6_Phr : Phr ;

  ex1_PConj : PConj ;

  ex1_Voc : Voc ;

  ex1_Utt, ex2_Utt, ex3_Utt, ex4_Utt, ex5_Utt, ex6_Utt, ex7_Utt, ex8_Utt, ex8_Utt, 
  ex9_Utt, ex10_Utt, ex11_Utt : Utt ;

  ex1_S, ex2_S, ex3_S, ex4_S, ex5_S, ex6_S, ex7_S : S ;

  ex1_Cl, ex2_Cl, ex3_Cl, ex4_Cl, ex5_Cl, ex6_Cl, ex7_Cl, ex8_Cl, ex9_Cl, ex10_Cl, 
  ex11_Cl, ex12_Cl, ex13_Cl, ex14_Cl, ex15_Cl, ex16_Cl, ex17_Cl, ex18_Cl, ex19_Cl,
  ex20_Cl, ex21_Cl, ex22_Cl, ex23_Cl, ex24_Cl, ex25_Cl : Cl ;

  ex1_VP, ex2_VP, ex3_VP, ex4_VP, ex5_VP, ex6_VP, ex7_VP, ex8_VP, ex9_VP, ex10_VP, 
  ex11_VP, ex12_VP, ex13_VP, ex14_VP, ex15_VP, ex16_VP, ex17_VP, ex18_VP, ex19_VP, 
  ex20_VP, ex21_VP, ex22_VP : VP ;

  ex1_NP, ex2_NP, ex3_NP, ex4_NP, ex5_NP, ex6_NP, ex7_NP, ex8_NP, ex9_NP, ex10_NP, 
  ex11_NP, ex12_NP, ex13_NP, ex14_NP, ex15_NP, ex16_NP, ex17_NP, ex18_NP, ex19_NP, 
  ex20_NP, ex21_NP, ex22_NP, ex23_NP : NP ;

  ex1_Det, ex2_Det, ex3_Det, ex4_Det, ex5_Det, ex6_Det, ex7_Det, ex8_Det, ex9_Det, 
  ex10_Det, ex11_Det, ex12_Det, ex13_Det, ex14_Det : Det ;

  ex1_Quant, ex2_Quant : Quant ;

  ex1_QuantSg, ex2_QuantSg : QuantSg ;

  ex1_QuantPl : QuantPl ;

  ex1_Num, ex2_Num, ex3_Num : Num ;

  ex1_Ord, ex2_Ord, ex3_Ord : Ord ;

  ex1_AdN : AdN ;

  ex1_Numeral, ex2_Numeral, ex3_Numeral, ex4_Numeral, ex5_Numeral, 
  ex6_Numeral, ex7_Numeral, ex8_Numeral, ex9_Numeral, 
  ex10_Numeral, ex11_Numeral, ex12_Numeral, ex13_Numeral : Numeral ;

  ex1_CN, ex2_CN, ex3_CN, ex4_CN, ex5_CN, ex6_CN, ex7_CN, ex8_CN, ex9_CN, ex10_CN, 
  ex11_CN, ex12_CN, ex13_CN, ex14_CN, ex15_CN, ex16_CN, ex17_CN, ex18_CN : CN ;

  ex1_AP, ex2_AP, ex3_AP, ex4_AP, ex5_AP, ex6_AP, ex7_AP, ex8_AP, ex9_AP, ex10_AP, 
  ex11_AP, ex12_AP, ex13_AP : AP ;

  ex1_Adv, ex2_Adv, ex3_Adv, ex4_Adv, ex5_Adv, ex6_Adv, ex7_Adv, ex8_Adv, 
  ex9_Adv, ex10_Adv : Adv ;

  ex1_QS, ex2_QS, ex3_QS : QS ;

  ex1_QCl, ex2_QCl, ex3_QCl, ex4_QCl, ex5_QCl, ex6_QCl, ex7_QCl, ex8_QCl : QCl ;
  
  ex1_IP, ex2_IP, ex3_IP : IP ;

  ex1_IAdv : IAdv ;

  ex1_RS, ex2_RS : RS ;

  ex1_RCl, ex2_RCl, ex3_RCl, ex4_RCl : RCl ;

  ex1_RP, ex2_RP : RP ;

  ex1_Slash, ex2_Slash, ex3_Slash, ex4_Slash : Slash ;

  ex1_ListS, ex2_ListS : ListS ;

  ex1_ListAdv, ex2_ListAdv : ListAdv ;

  ex1_ListAP, ex2_ListAP : ListAP ;

  ex1_ListNP, ex2_ListNP : ListNP ;


-- auxiliary to show VP's

  utt : VP -> Utt ;

}
