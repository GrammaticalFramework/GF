abstract Exx = Cat-[VP] ** {

cat VP ; --- hack to circumvent missing lockfields in overload resolution

fun

  ex1_Text, ex2_Text, ex3_Text, ex4_Text, ex5_Text, ex6_Text, ex7_Text, ex8_Text : Text ;

  ex1_Phr, ex2_Phr, ex3_Phr, ex4_Phr, ex5_Phr, ex6_Phr : Phr ;

  ex1_PConj : PConj ;

  ex1_Voc : Voc ;

  ex1_Utt, ex2_Utt, ex3_Utt, ex4_Utt, ex5_Utt, ex6_Utt, ex7_Utt, ex8_Utt, ex8_Utt, ex9_Utt, ex10_Utt, ex11_Utt : Utt ;

  ex1_S, ex2_S, ex3_S, ex4_S, ex5_S, ex6_S, ex7_S : S ;

  ex1_Cl, ex2_Cl, ex3_Cl, ex4_Cl, ex5_Cl, ex6_Cl, ex7_Cl, ex8_Cl, ex9_Cl, ex10_Cl, 
  ex11_Cl, ex12_Cl, ex13_Cl, ex14_Cl, ex15_Cl, ex16_Cl, ex17_Cl, ex18_Cl, ex19_Cl, ex20_Cl,
  ex21_Cl, ex22_Cl, ex23_Cl, ex24_Cl, ex25_Cl : Cl ;

  ex1_VP, ex2_VP, ex3_VP, ex4_VP, ex5_VP, ex6_VP, ex7_VP, ex8_VP, ex9_VP, ex10_VP, 
  ex11_VP, ex12_VP, ex13_VP, ex14_VP, ex15_VP, ex16_VP, ex17_VP, ex18_VP, ex19_VP, ex20_VP, 
  ex21_VP, ex22_VP : VP ;

  ex1_NP, ex2_NP, ex3_NP, ex4_NP, ex5_NP, ex6_NP, ex7_NP, ex8_NP, ex9_NP, ex10_NP, 
  ex11_NP, ex12_NP, ex13_NP, ex14_NP, ex15_NP, ex16_NP, ex17_NP, ex18_NP, ex19_NP, ex20_NP, 
  ex21_NP, ex22_NP, ex23_NP : NP ;


-- auxiliary to show VP's

  utt : VP -> Utt ;

}
