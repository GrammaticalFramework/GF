abstract ExtraEngAbs = Extra - [ProDrop] ** {

-- uncontracted negative polarity; contracted is the default for PNeg
  fun 
    UncNeg : Pol ;

-- freely compounded nouns

    CompoundCN : CN -> CN -> CN ;       -- rock album

    which_who_RP : RP ;  -- "which" / "who" as a relative pronoun (used to be the default for IdRP) 
    that_RP : RP ;  -- "that" as a relational pronoun (since 5/6/2016 default for IdRP)
    which_RP : RP ; -- force "which"
    who_RP : RP ;   -- force "who" ; in Acc, also "who": "the girl who I saw"
    emptyRP : RP ;  -- empty RP in Acc position: "the girl I saw"

    each_Det : Det ;
    any_Quant : Quant ;

-- infinitive without to

    UttVPShort : VP -> Utt ;

-- emphasizing "do", e.g. "John does walk"

   do_VV : VV ;

   may_VV : VV ;
   shall_VV : VV ;
   ought_VV : VV ;
   used_VV : VV ;

   --- AR 7/3/2013
   ComplSlashPartLast : VPSlash -> NP -> VP ;

   --- AR 3/12/2013 ---- TODO: the same for QCl, RCl
   ContractedUseCl : Temp -> Pol -> Cl  -> S ;   -- he's here, I'll be back


-----------------------------------------------------
--- these are obsolete: use UncNeg : Pol instead

  fun
    UncNegCl  : Temp -> Pol -> Cl  -> S ;
    UncNegQCl : Temp -> Pol -> QCl -> QS ;
    UncNegRCl : Temp -> Pol -> RCl -> RS ;

    UncNegImpSg : Pol -> Imp -> Utt;           -- do not help yourself
    UncNegImpPl : Pol -> Imp -> Utt;           -- do not help yourselves
-----------------------------------------------------


}
