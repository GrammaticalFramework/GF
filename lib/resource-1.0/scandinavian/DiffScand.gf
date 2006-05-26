interface DiffScand = open CommonScand, Prelude in {

-- Parameters.

  param
    Gender ;

  oper
    neutrum, utrum : Gender ;

    gennum : Gender -> Number -> GenNum ;

-- This is the form of the noun in "det stora berget"/"det store berg".

    detDef : Species ;

-- Danish verbs have a marking for compound-tense auxiliary ("have" or "være").

    Verb : Type ;

    hasAuxBe : Verb -> Bool ;

-- Strings.

    conjThat : Str ;
    conjThan : Str ;
    conjAnd  : Str ;
    infMark  : Str ;

    subjIf : Str ;

    artIndef : Gender => Str ;

    verbHave : Verb ;
    verbBe   : Verb ;

    verbBecome : Verb ;

    auxFut : Str ;
    auxCond : Str ;

    negation : Polarity => Str ;

-- For determiners; mostly two-valued even in Norwegian.

    genderForms : (x1,x2 : Str) -> Gender => Str ;

-- The forms of a relative pronoun ("som", "vars", "i vilken").

    relPron : GenNum => RCase => Str ;

-- Pronoun "sådan" used in $Relative.RelCl$.

    pronSuch : GenNum => Str ;

    reflPron : Agr -> Str ;

}

