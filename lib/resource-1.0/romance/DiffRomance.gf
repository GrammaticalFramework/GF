interface DiffRomance = open CommonRomance, Prelude in {

--2 Constants whose definitions depend on language.

-- Prepositions that fuse with the article vary.

param

  Prep ;
  VType ;

oper

  dative    : Case ;
  genitive  : Case ;

  prepCase  : Case -> Str ;

  partitive : Gender -> Case -> Str ;

  artDef    : Gender -> Number -> Case -> Str ;
  artIndef  : Gender -> Number -> Case -> Str ;

  auxVerb   : VType -> (VF => Str) ;
  negation  : Polarity => (Str * Str) ;
  copula    : Verb ;

  partAgr   : VType -> VPAgr ;

  conjThan  : Str ;
  conjThat  : Str ;

  clitInf   : Str -> Str -> Str ;

  relPron   : Bool => AAgr => Case => Str ;
  pronSuch  : AAgr => Str ;

  partQIndir : Str ; -- ce, ciò

  reflPron : Number => Person => Case => Str ;

  vRefl   : VType ;
  isVRefl : VType -> Bool ;

  auxPassive : Verb ;


-- These are needed above.

param
  Case = Nom | Acc | CPrep Prep ; 

oper
  Verb = {s : VF => Str ; vtyp : VType} ;

}

