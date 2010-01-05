instance LexAttemptoSwe of LexAttempto = 
  open ExtraSwe, SyntaxSwe, ParadigmsSwe, ConstructX, 
    MakeStructuralSwe, IrregSwe in {

oper
  possible_A = mkA "möjlig" ;
  necessary_A = mkA "nödvändig" ;
  own_A = mkA "egen" "eget" "egna" "egnare" "egnast" ;
  have_VV = must_VV ;
  provably_Adv = mkAdv "bevisbart" ;
  provable_A = mkA "bevisbar" ;
  false_A = mkA "falsk" ;
  such_A = mkA "sådan" ;

  genitiveNP np = mkNP (GenNP np) ;

  each_Det = every_Det ; ----

  that_Subj = mkSubj "att" ;

  comma_and_Conj = mkConj [] ", och" plural ;
  comma_or_Conj = mkConj [] ", eller" singular ;
  slash_Conj = mkConj [] "/" singular ;
  whose_IDet = mkIDet (mkIQuant "vems" "vems" "vems" dDefIndef) ;

  eachOf np = mkNP (mkPredet "var och en" "vart och ett" "av" singular) np ;

  adj_thatCl : A -> S -> Cl = \a,s -> mkCl (mkVP (mkAP (mkAP a) s)) ;

}
