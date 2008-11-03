instance LexAttemptoGer of LexAttempto = 
  open ExtraGer, SyntaxGer, ParadigmsGer, ConstructX, IrregGer in {

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

}
