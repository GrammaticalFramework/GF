abstract ExtraEngAbs = Extra ** {

-- uncontracted negations; contracted are the default
  fun
    UncNegCl  : Temp -> Cl  -> S ;
    UncNegQCl : Temp -> QCl -> QS ;
    UncNegRCl : Temp -> RCl -> RS ;

    UncNegImpSg : Imp -> Utt;           -- do not help yourself
    UncNegImpPl : Imp -> Utt;           -- do not help yourselves

-- freely compounded nouns

    CompoundCN : CN -> CN -> CN ;       -- rock album

}
