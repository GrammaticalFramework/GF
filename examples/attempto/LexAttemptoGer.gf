instance LexAttemptoGer of LexAttempto = 
  open ExtraGer, SyntaxGer, ParadigmsGer, ConstructX,
    MakeStructuralGer, 
    IrregGer in {

oper
  possible_A = mkA "möglich" ;
  necessary_A = mkA "nötig" ;
  own_A = mkA "eigen" ;
  have_VV = SyntaxGer.must_VV ;
  provably_Adv = mkAdv "beweisbar" ;
  provable_A = mkA "beweisbar" ;
  false_A = mkA "falsch" ;
  such_A = mkA "solch" ;

  genitiveNP np cn = mkNP (mkNP the_Art cn) (SyntaxGer.mkAdv possess_Prep np) ;

  each_Det = every_Det ;

  that_Subj = mkSubj "daß" ;

  comma_and_Conj = mkConj [] ", und" plural ;
  comma_or_Conj = mkConj [] ", oder" singular ;
  slash_Conj = mkConj [] "/" singular ;

  whose_IDet = mkIDet (mkIQuant "wessen") ;

  eachOf np = mkNP (mkNP each_Det) (SyntaxGer.mkAdv part_Prep np) ;  ---- gen agr

  adj_thatCl : A -> S -> Cl = \a,s -> mkCl (mkVP (mkAP (mkAP a) s)) ;

}
