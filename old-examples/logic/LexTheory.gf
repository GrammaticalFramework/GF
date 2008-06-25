interface LexTheory = open Grammar in {

  oper
    assume_VS : VS ;
    case_N : N ;
    contradiction_N : N ;
    have_V2 : V2 ;
    hypothesis_N : N ;
    ifthen_DConj : DConj ;

    defNP : Str -> NP ;

}
