--1 French Word Classes and Morphological Parameters
--
-- This is a resource module for Italian morphology, defining the
-- morphological parameters and word classes of Italian. 
-- The morphology is so far only
-- complete w.r.t. the syntax part of the resource grammar.
-- It does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.

instance TypesFre of TypesRomance = {

-- Now we can give values to the abstract types.

param
  Case = Nom | Acc | Gen | Dat ; -- corresp. to prepositions de and à

  NPForm = Ton Case | Aton Case | Poss Number Gender ;

oper 
  CaseA = Case ;
  NPFormA = NPForm ;

  nominative = Nom ;
  accusative = Acc ;
  genitive = Gen ;
  dative = Dat ;
  prepositional = accusative ;

  stressed = Ton ;
  unstressed = Aton ;

------------------------- move this somewhere else!
--2 Some phonology
--
--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- There is one thing that is not treated properly: the "h aspiré",
-- which is not separated orthographically from the "h muet".
-- Our definition works correctly only for the "h muet".

oper 
  voyelle : Strs = strs {
    "a" ; "â" ; "à" ; "e" ; "ê" ; "é" ; "è" ; 
    "h" ; 
    "i" ; "î" ; "o" ; "ô" ; "u" ; "û" ; "y"
    } ;

  elision : Str -> Str = \d -> d + pre {"e" ; "'" / voyelle} ;

-- The following morphemes are the most common uses of elision.

  elisDe  = elision "d" ;
  elisLa  = pre {"la" ; "l'" / voyelle} ;
  elisLe  = elision "l" ;
  elisNe  = elision "n" ;
  elisQue = elision "qu" ;

-- The subjunction "si" has a special kind of elision. The rule is
-- only approximatively correct, for "si" is not really elided before
-- the string "il" in general, but before the pronouns "il" and "ils".

  elisSi = pre {"si" ; "s'" / strs {"il"}} ;


--2 Prepositions
--
-- The type $Cas$ in $types.Fra.gf$ has the dative and genitive
-- cases, which are relevant for pronouns and the definite article,
-- but which are otherwise expressed by prepositions.

  prepCase = \c -> case c of {
    Nom => [] ;
    Acc => [] ; 
    Gen => elisDe ; 
    Dat => "à"
    } ;

--2 Relative pronouns
--
-- The simple (atonic) relative pronoun shows genuine variation in all of the
-- cases. 

  relPronForms = table {
    Nom => "qui" ; Gen => "dont" ; Dat => ["à qui"] ; Acc => elisQue
    } ;

-- Usually the comparison forms are built by prefixing the word
-- "plus". The definite article needed in the superlative is provided in
-- $syntax.Fra.gf$.

  adjCompLong : Adj -> AdjComp = \cher ->
    mkAdjComp 
      cher.s 
      (\\a => "plus" ++ cher.s ! a) ;

-- Comparative adjectives are only sometimes formed morphologically
-- (actually: by different morphemes).

  mkAdjComp : (_,_ : AForm => Str) -> AdjComp = 
    \bon, meilleur -> 
    {s = table {Pos => bon ; _ => meilleur}} ;

------------------------------

-- Their inflection tables has tonic and atonic forms, as well as
-- the possessive forms, which are inflected like determiners.
--
-- Example: "lui, de lui, à lui" - "il,le,lui" - "son,sa,ses".

--
-- Examples of each: "Jean" ; "je"/"te" ; "il"/"elle"/"ils"/"elles" ; "nous"/"vous".

-- The following coercions are useful:

oper
  pform2case = \p -> case p of {
       Ton  x   => x ;
       Aton x   => x ;
       Poss _ _ => Gen
       } ;

  case2pform = \c -> case c of {
    Nom => Aton Nom ;
    Acc => Aton Acc ;
    _   => Ton c
    } ;

  case2pformClit = \c -> case c of {
    Nom => Aton Nom ;
    Acc => Aton Acc ;
    Dat => Aton Dat ;
    _   => Ton c
    } ;

-- Relative pronouns: the case-dependent parameter type.

  param RelForm = RSimple Case | RComplex Gender Number Case ;

  oper RelFormA = RelForm ;

-- Verbs: conversion from full verbs to present-tense verbs.

  verbPres = \aller,a -> {s = vvf aller ; aux = a} ;

  vvf : (VForm => Str) -> (VF => Str) = \aller -> table { 
    VInfin       => aller ! Inf ;
    VFin (VPres   Ind) n p => aller ! Indic Pres n p ; 
    VFin (VPres   Sub) n p => aller ! Subjo SPres n p ;
    VFin (VImperf Ind) n p => aller ! Indic Imparf n p ; 
    VFin (VImperf Sub) n p => aller ! Subjo SImparf n p ;
    VFin VPasse n p  => aller ! Indic Passe n p ;
    VFin VFut n p    => aller ! Indic Futur n p ;
    VFin VCondit n p => aller ! Cond n p ;
    VImper np    => aller ! Imper np ;
    VPart g n    => aller ! Part (PPasse g n)
    } ;

-- The full conjunction is a table on $VForm$:

param
  Temps    = Pres | Imparf | Passe | Futur ;
  TSubj    = SPres | SImparf ;
  TPart    = PPres | PPasse Gender Number ;
  VForm    = Inf
           | Indic Temps Number Person 
           | Cond Number Person 
           | Subjo TSubj Number Person
           | Imper NumPersI
           | Part TPart ;

-- This is the full verb type.

oper
  Verbum : Type = VForm => Str ;
}
