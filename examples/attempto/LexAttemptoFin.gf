instance LexAttemptoFin of LexAttempto = 
  open 
   ExtraFin,  
   SyntaxFin, 
   ParadigmsFin, 
   ConstructX, 
   (M = MakeStructuralFin)
   in {

oper
  possible_A = mkA "mahdollinen" ;
  necessary_A = mkA "välttämätön" ;
  own_A = mkA "oma" ;
  have_VV = mkVV (mkV "pitää") ;
  provably_Adv = mkAdv "todistettavasti" ;
  provable_A = mkA "todistettava" ;
  false_A = mkA (mkN "epätosi" "epätosia") ;
  such_A = mkA "sellainen" ;
 
  genitiveNP np = mkNP (GenNP np) ;

  kilogram_CN = mkCN (mkN "kilo") ;

  each_Det = every_Det ; ----

  that_Subj = M.mkSubj "että" ;

  comma_and_Conj = M.mkConj [] ", ja" plural ;
  comma_or_Conj = M.mkConj [] ", tai" singular ;
  slash_Conj = M.mkConj [] "/" singular ;

  whose_IDet = mkIDet (M.mkIQuant "kenen") ;

  eachOf np = mkNP (mkNP each_Det) (SyntaxFin.mkAdv (casePrep elative) np) ;

}
