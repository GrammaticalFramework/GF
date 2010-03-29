instance LexAttemptoUrd of LexAttempto = 
  open 
   ExtraUrd,  
   SyntaxUrd, 
   ParadigmsUrd, 
   ConstructX, 
   (M = MakeStructuralUrd)
--   IrregUrd 
   in {

oper
  possible_A = mkA "mmkn" ;
  necessary_A = mkA "Zrwry" ;
  own_A = mkA "apna" ;
  have_VV = mkVV have_V ;
  provably_Adv = ParadigmsUrd.mkAdv "sabt" ;
  provable_A = mkA "sabt" ;
  false_A = mkA "GlT" ;
  such_A = mkA "aisa" ;
 
  genitiveNP np = mkNP (GenNP np) ;

  kilogram_CN = mkCN (mkN "klwgram") ;

  each_Det = ExtraUrd.each_Det ;

  that_Subj = M.mkSubj "kh" ;

  comma_and_Conj = mkConj [] "awr" plural ;
  comma_or_Conj = mkConj [] "ya" singular ;
  slash_Conj = mkConj [] "/" singular ;

  whose_IDet = M.mkIDet "ks ka" singular ;

  eachOf np = mkNP (mkNP each_Det) (SyntaxUrd.mkAdv part_Prep np) ;

  adj_thatCl : A -> S -> Cl = \a,s -> mkCl (mkVP (mkAP (mkAP a) s)) ;

}
