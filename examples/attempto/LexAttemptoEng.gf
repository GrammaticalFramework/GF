instance LexAttemptoEng of LexAttempto = 
  open 
   ExtraEng,  
   SyntaxEng, 
   ParadigmsEng, 
   ConstructX, 
   IrregEng in {

oper
  possible_A = mkA "possible" ;
  necessary_A = mkA "necessary" ;
  own_A = mkA "own" ;
  have_VV = mkVV have_V ;
  provably_Adv = mkAdv "provably" ;
  provable_A = mkA "provable" ;
  false_A = mkA "false" ;
  such_A = mkA "such" ;
 
  genitiveNP np = mkNP (GenNP np) ;

  kilogram_CN = mkCN (mkN "kilogram") ;

  each_Det = ExtraEng.each_Det ;

}
