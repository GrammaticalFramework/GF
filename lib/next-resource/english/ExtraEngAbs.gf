abstract ExtraEngAbs = Extra ** {

-- uncontracted negations; contracted are the default
  fun
    UncNegCl  : Tense -> Ant -> Cl  -> S ;
    UncNegQCl : Tense -> Ant -> QCl -> QS ;
    UncNegRCl : Tense -> Ant -> RCl -> RS ;

    UncNegImpSg : Imp -> Utt;           -- do not help yourself
    UncNegImpPl : Imp -> Utt;           -- do not help yourselves

-- freely compounded nouns

    CompoundCN : CN -> CN -> CN ;       -- rock album

}
