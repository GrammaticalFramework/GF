abstract ExtraGreAbs = Extra  ** {

  fun 
    TPasse, TImperf : Tense ; 


theyFem_Pron: Pron ;
theyNeut_Pron: Pron ;

   UttImpSgImperf  : Pol -> Imp -> Utt;          -- (don't) love yourself
   UttImpPlImperf  : Pol -> Imp -> Utt;          -- (don't) love yourselves
}