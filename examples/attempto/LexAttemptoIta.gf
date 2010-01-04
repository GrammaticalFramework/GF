instance LexAttemptoIta of LexAttempto = 
  open ExtraIta, SyntaxIta, ParadigmsIta, ConstructX, 
    MakeStructuralIta, (P = Prelude)
    in {

oper
  possible_A = mkA "possibile" ;
  necessary_A = mkA "necessario" ;
  own_A = mkA "proprio" ;
  have_VV = SyntaxIta.must_VV ;
  provably_Adv = mkAdv "dimostrabilmente" ;
  provable_A = mkA "dimostrabile" ;
  false_A = mkA "falso" ;
  such_A = mkA "tale" ;

  genitiveNP np cn = mkNP (mkNP the_Art cn) (SyntaxIta.mkAdv possess_Prep np) ;

  each_Det = every_Det ; ----

  that_Subj = mkSubj "che" ;

  comma_and_Conj = mkConj [] ", e" plural ;
  comma_or_Conj = mkConj [] ", o" singular ;
  slash_Conj = mkConj [] "/" singular ;

  whose_IDet = mkIDet (mkIQuant "de chi") ; ----

  eachOf np = mkNP (mkPredet "ciascuno" "ciascuna" genitive P.True) np ;
}
