interface DiffScand = open CommonScand, Prelude in {

--1 Differences between Scandinavian languages

-- Norway has three genders, Danish and Swedish have two.

  param
    Gender ;

  oper
    neutrum, utrum : Gender ;

    gennum : Gender -> Number -> GenNum ;

-- This is the form of the noun in "det stora berget"/"det store berg".

    detDef : Species ;

-- Danish and Norwegian verbs, but not Swedish verbs, 
-- have two possible compound-tense auxiliaries ("have" or "være").

    Verb : Type ;

    hasAuxBe : Verb -> Bool ;

-- The rest of the parameters are function words used in the syntax modules.

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

