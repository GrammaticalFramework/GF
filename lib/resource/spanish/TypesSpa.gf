--1 Spanish Word Classes and Morphological Parameters
--
-- This is a resource module for Spanish morphology, defining the
-- morphological parameters and word classes of Spanish. 
-- The morphology is so far only
-- complete w.r.t. the syntax part of the resource grammar.
-- It does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.

instance TypesSpa of TypesRomance = {

-- First we give values to the abstract types.

param
  Case = Nom | Acc | CPrep Prep ; 

  Prep = P_de | P_a ;

  NPForm = Ton Case | Aton Case | Poss Number Gender ;

--2 Prepositions
--
-- The type $Case$ in $types.Ita.gf$ has the dative and genitive
-- cases, which are relevant for pronouns and the definite article,
-- but which are otherwise expressed by prepositions.

oper
  prepCase = \c -> case c of {
    Nom => [] ;
    Acc => [] ; 
    CPrep p => strPrep p
    } ;

  strPrep : Prep -> Str = \p -> case p of {
    P_de => "de" ;
    P_a  => "a"
    } ;

  prepositional = accusative ;

oper 
  CaseA = Case ;
  NPFormA = NPForm ;

  nominative = Nom ;
  accusative = Acc ;
  genitive = CPrep P_de ;
  dative = CPrep P_a ;

  stressed = Ton ;
  unstressed = Aton ;

oper
  pform2case = \p -> case p of {
    Ton  x   => x ;
    Aton x   => x ;
    Poss _ _ => genitive
    } ;

  case2pform = \c -> case c of {
    Nom => Aton Nom ;
    Acc => Aton Acc ;
    _   => Ton c
    } ;

  case2pformClit = \c -> case c of {
    Nom => Aton Nom ;
    Acc => Aton Acc ;
    CPrep P_a => Aton c ;
    _   => Ton c
    } ;

-- Comparative adjectives are only sometimes formed morphologically
-- (actually: by different morphemes).

  mkAdjComp : (_,_ : AForm => Str) -> AdjComp = 
    \buono, migliore -> 
    {s = table {Pos => buono ; _ => migliore}} ;

-- Usually the comparison forms are built by prefixing the word
-- "mas". The definite article needed in the superlative is provided in
-- $syntax.Ita.gf$.

  adjCompLong : Adj -> AdjComp = \caro ->
    mkAdjComp 
      caro.s 
      (\\gn => "mas" ++ caro.s ! gn) ;


-- Relative pronouns: the case-dependent parameter type.

  param RelForm = RSimple Case | RComplex Gender Number Case ;

  oper RelFormA = RelForm ;

--2 Relative pronouns
--
-- The simple (atonic) relative pronoun shows genuine variation in all of the
-- cases. 

  relPronForms = table {
    Nom => "che" ; 
    Acc => "che" ;
    CPrep P_a => "cui" ;    --- variant a cui
    CPrep p => strPrep p ++ "cui"
    } ;

-- Verbs: conversion from full verbs to present-tense verbs.

  verbPres = \amare,a -> {s = table { 
    VInfin                 => amare.s ! VI Infn ;
    VFin (VPres   Ind) n p => amare.s ! VP (Pres Ind  n p) ; 
    VFin (VPres   Sub) n p => amare.s ! VP (Pres Sub n p) ;
    VFin (VImperf Ind) n p => amare.s ! VP (Impf Ind  n p) ; 
    VFin (VImperf Sub) n p => amare.s ! VP (Impf Sub n p) ;
    VFin VPasse n p        => amare.s ! VP (Pret n p) ;
    VFin VFut n p          => amare.s ! VP (Fut  Ind n p) ;
    VFin VCondit n p       => amare.s ! VP (Cond n p) ;
    VImper np              => amare.s ! VP (Imp  Sg P2) ; ---- n p ;
    VPart g n              => amare.s ! VP (Pass n g)
    } ;
  aux = a
  } ;


-- The full conjunction is a table on $VForm$:

param
  VImpers =   
     Infn   
   | Ger   
   | Part
   ;
   
  VPers =   
     Pres Mode Number Person   
   | Impf Mode Number Person   
   | Pret      Number Person   
   | Fut  Mode Number Person   
   | Cond      Number Person   
   | Imp       Number Person
   | Pass      Number Gender   
   ;
   
  VForm =   
     VI VImpers   
   | VP VPers   
   ;

-- This is the full verb type.

oper Verbum = {s : VForm => Str} ;
}
