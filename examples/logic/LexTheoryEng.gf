instance LexTheoryEng of LexTheory = open 
  GrammarEng, ParadigmsEng, IrregEng, ParamX in {
  oper
    assume_VS = mkVS (regV "assume") ;
    case_N = regN "case" ;
    contradiction_N = regN "contradiction" ;
    have_V2 = dirV2 have_V ;
    hypothesis_N = mk2N "hypothesis" "hypotheses" ;
    ifthen_DConj = {s1 = "if" ; s2 = "then" ; n = singular ; lock_DConj = <>} ;

    defNP s = {s = \\_ => s ; a = {n = Sg ; p = P3} ; lock_NP = <>} ;

}
