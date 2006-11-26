instance LexTheoryEng of LexTheory = open GrammarEng,ParadigmsEng,IrregEng in {
  oper
    assume_VS = mkVS (regV "assume") ;
    case_N = regN "case" ;
    have_V2 = dirV2 have_V ;

}
