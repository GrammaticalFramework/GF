abstract ExtraEngAbs = Extra ** {

-- uncontracted negations; contracted are the default
  fun
    UncNegCl  : Temp -> Pol -> Cl  -> S ;
    UncNegQCl : Temp -> Pol -> QCl -> QS ;
    UncNegRCl : Temp -> Pol -> RCl -> RS ;

    UncNegImpSg : Pol -> Imp -> Utt;           -- do not help yourself
    UncNegImpPl : Pol -> Imp -> Utt;           -- do not help yourselves

-- freely compounded nouns

    CompoundCN : CN -> CN -> CN ;       -- rock album

    that_RP : RP ; -- "that" as a relational pronoun (IdRP is "which" / "who")

    each_Det : Det ;
}
