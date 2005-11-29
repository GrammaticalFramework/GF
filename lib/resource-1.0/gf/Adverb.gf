abstract Adverb = Cat ** {

  fun

    PositAdvAdj   : A -> Adv ;
    ComparAdvAdj  : CAdv -> A -> NP -> Adv ;
    ComparAdvAdjS : CAdv -> A -> S -> Adv ;

    PrepNP : Prep -> NP -> Adv ;

    AdAdv  : AdA -> Adv -> Adv ;

    SubjS : Subj -> S -> Adv ;

}
