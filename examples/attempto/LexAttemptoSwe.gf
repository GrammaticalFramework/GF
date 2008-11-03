instance LexAttemptoSwe of LexAttempto = 
  open ExtraSwe, SyntaxSwe, ParadigmsSwe, ConstructX, IrregSwe in {

oper
  possible_A = mkA "möjlig" ;
  necessary_A = mkA "nödvändig" ;
  own_A = mkA "egen" ;
  have_VV = must_VV ;
  provably_Adv = mkAdv "bevisbart" ;
  provable_A = mkA "bevisbar" ;
  false_A = mkA "falsk" ;
  such_A = mkA "sådan" ;

  genitiveNP np = mkNP (GenNP np) ;

  each_Det = every_Det ; ----
}
