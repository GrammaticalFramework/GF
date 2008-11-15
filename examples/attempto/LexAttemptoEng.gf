instance LexAttemptoEng of LexAttempto = 
  open 
   ExtraEng,  
   SyntaxEng, 
   ParadigmsEng, 
   ConstructX, 
   (M = MakeStructuralEng),
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

  that_Subj = M.mkSubj "that" ;

  comma_and_Conj = M.mkConj [] ", and" plural ;
  comma_or_Conj = M.mkConj [] ", or" singular ;
  slash_Conj = M.mkConj [] "/" singular ;


}
