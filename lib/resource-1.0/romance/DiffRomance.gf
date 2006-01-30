interface DiffRomance = open CommonRomance, Prelude in {

--2 Constants whose definitions fundamentally depend on language

-- Prepositions that fuse with the article
-- (Fre, Spa "de", "a"; Ita also "in", "con").

  param Prep ;

-- Which types of verbs exist, in terms of auxiliaries.
-- (Fre, Ita "avoir", "être", and refl; Spa only "haber" and refl).

  param VType ;

-- Derivatively, if/when the participle agrees to the subject.
-- (Fre "elle est partie", Ita "lei è partita", Spa not)

  oper partAgr   : VType -> VPAgr ;

-- Whether participle agrees to foregoing clitic.
-- (Fre "je l'ai vue", Ita "io la ho visto")

  oper vpAgrClit : Agr -> VPAgr ;

-- Whether a preposition is repeated in conjunction
-- (Fre "la somme de 3 et de 4", Ita "la somma di 3 e 4").

  oper conjunctCase : NPForm -> NPForm ;


--2 Constants that must derivatively depend on language

  dative    : Case ;
  genitive  : Case ;

  vRefl   : VType ;
  isVRefl : VType -> Bool ;


--2 Strings

  prepCase  : Case -> Str ;

  partitive : Gender -> Case -> Str ;

  artDef    : Gender -> Number -> Case -> Str ;
  artIndef  : Gender -> Number -> Case -> Str ;

  auxVerb   : VType -> (VF => Str) ;
  negation  : Polarity => (Str * Str) ;
  copula    : Verb ;

  conjThan  : Str ;
  conjThat  : Str ;

  clitInf   : Str -> Str -> Str ;

  relPron   : Bool => AAgr => Case => Str ;
  pronSuch  : AAgr => Str ;

  partQIndir : Str ; -- ce, ciÃ²

  reflPron : Number => Person => Case => Str ;

  auxPassive : Verb ;


--2 Contants needed in type signatures above

param
  Case = Nom | Acc | CPrep Prep ; 
  NPForm = Ton Case | Aton Case | Poss {g : Gender ; n : Number} ; --- AAgr

oper
  Verb = {s : VF => Str ; vtyp : VType} ;

}

