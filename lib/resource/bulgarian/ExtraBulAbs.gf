abstract ExtraBulAbs = Extra ** {

fun
  GenNPIndef : NP -> Quant ;

-- Feminine variants of pronouns (those in $Structural$ are
-- masculine, which is the default when gender is unknown).

  i8fem_Pron : Pron ;
  i8neut_Pron : Pron ;

  whatSg8fem_IP : IP ;
  whatSg8neut_IP : IP ;

  whoSg8fem_IP : IP ;
  whoSg8neut_IP : IP ;
    
  youSg8fem_Pron : Pron ;
  youSg8neut_Pron : Pron ;

  youPol8fem_Pron : Pron ;
  youPol8neut_Pron : Pron ;
  
  onePl_Num : Num ;
  
  UttImpSg8fem  : Pol -> Imp -> Utt;
  UttImpSg8neut : Pol -> Imp -> Utt;
}
