abstract ExtraEngAbs = Extra - [ProDrop] ** {

-- uncontracted negative polarity; contracted is the default for PNeg
  fun 
    UncNeg : Pol ;

-- freely compounded nouns

    CompoundCN : CN -> CN -> CN ;       -- rock album

    that_RP : RP ; -- "that" as a relational pronoun (IdRP is "which" / "who")

    each_Det : Det ;
    any_Quant : Quant ;

-- infinitive without to

    UttVPShort : VP -> Utt ;

-- emphasizing "do", e.g. "John does walk"

   do_VV : VV ;

   may_VV : VV ;

   shall_VV : VV ;

   --- AR 7/3/2013
   ComplSlashPartLast : VPSlash -> NP -> VP ;

---------------------
--- these are obsolete: use UncNeg : Pol instead

  fun
    UncNegCl  : Temp -> Pol -> Cl  -> S ;
    UncNegQCl : Temp -> Pol -> QCl -> QS ;
    UncNegRCl : Temp -> Pol -> RCl -> RS ;

    UncNegImpSg : Pol -> Imp -> Utt;           -- do not help yourself
    UncNegImpPl : Pol -> Imp -> Utt;           -- do not help yourselves



}
