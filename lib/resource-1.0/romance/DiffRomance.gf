--1 Differences between Romance languages

interface DiffRomance = open CommonRomance, Prelude in {

-- The first six constants show the essential differences
-- between French, Italian, and Romance syntaxes (as regards the
-- resource API). The other constants are either derivatively
-- dependent, or have as values strings, which are language-dependent
-- anyway.

--2 Constants whose definitions fundamentally depend on language

-- Prepositions that fuse with the article
-- (Fre, Spa "de", "a"; Ita also "con", "da", "in", "su).

  param Prep ;

-- Forms of noun phrases. Spanish and Italian have special forms for
-- fronted clitics.

  param NPForm ;

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

-- How infinitives and clitics are placed relative to each other
-- (Fre "la voir", Ita "vederla").

  oper clitInf : Str -> Str -> Str ;

-- If a new clitic is placed before an existing one.
-- (Fre "le lui", Ita "glie lo").

  placeNewClitic : 
    (Case * Number * Person) ->                       -- info on old clit
    Case ->                                           -- case of new clit
    {s : NPForm => Str ; a : Agr ; hasClit : Bool} -> -- new clit
    Bool ->                                           -- whether to clit'ze
    Str ->                                            -- old clit
    Str ;                                             -- old + new (or rev.)


--2 Constants that must derivatively depend on language

----  nominative : Case ;
----  accusative : Case ;
  dative     : Case ;
  genitive   : Case ;

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

  relPron   : Bool => AAgr => Case => Str ;
  pronSuch  : AAgr => Str ;

  partQIndir : Str ; -- ce, ciÃ²

  reflPron : Number => Person => Case => Str ;

  auxPassive : Verb ;


--2 Contants needed in type signatures above

param
  Case = Nom | Acc | CPrep Prep ; 

oper
  Verb = {s : VF => Str ; vtyp : VType} ;

}

