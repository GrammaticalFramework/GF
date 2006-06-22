--1 Italian Word Classes and Morphological Parameters
--
-- This is a resource module for Italian morphology, defining the
-- morphological parameters and word classes of Italian. 
-- The morphology is so far only
-- complete w.r.t. the syntax part of the resource grammar.
-- It does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.

instance TypesIta of TypesRomance = {

-- First we give values to the abstract types.

param
  Case = Nom | Acc | CPrep Prep ; 

  Prep = P_di | P_a | P_da | P_in | P_su | P_con ;

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
    P_di => "di" ;
    P_a  => "a" ;
    P_da => "da" ;
    P_in => "in" ;
    P_su => "su" ;
    P_con => "con"
    } ;

oper 
  CaseA = Case ;
  NPFormA = NPForm ;

  prepositional = accusative ;

  nominative = Nom ;
  accusative = Acc ;
  genitive = CPrep P_di ;
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
-- "più". The definite article needed in the superlative is provided in
-- $syntax.Ita.gf$.

  adjCompLong : Adj -> AdjComp = \caro ->
    mkAdjComp 
      caro.s 
      (\\gn => "più" ++ caro.s ! gn) ;


-- Relative pronouns: the case-dependent parameter type.

  param RelForm = RSimple Case | RComplex Gender Number Case ;

  oper RelFormA = RelForm ;

  npRelForm : NPFormA -> RelFormA = \np -> case np of {
    Ton c => RSimple c ;
    Aton c => RSimple c ;
    Poss _ _ => RSimple genitive
    } ;

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
    VInfin                 => amare.s ! Inf ;
    VFin (VPres   Ind) n p => amare.s ! Indi Pres n p ; 
    VFin (VPres   Sub) n p => amare.s ! Cong Pres n p ;
    VFin (VImperf Ind) n p => amare.s ! Indi Imperf n p ; 
    VFin (VImperf Sub) n p => amare.s ! Cong Imperf n p ;
    VFin VPasse n p        => amare.s ! Pass n p ;
    VFin VFut n p          => amare.s ! Fut  n p ;
    VFin VCondit n p       => amare.s ! Cond n p ;
    VImper np              => amare.s ! Imper np ;
    VPart g n              => amare.s ! Part PassP g n ;
    VGer                   => amare.s ! Ger
    } ;
  aux = a
  } ;


-- The full conjunction is a table on $VForm$:

param 
  Tempo    = Pres | Imperf ;
  TempoP   = PresP | PassP ;
  VForm =
     Inf
   | InfClit
   | Indi  Tempo  Number   Person
   | Pass         Number   Person
   | Fut          Number   Person
   | Cong  Tempo  Number   Person
   | Cond         Number   Person
   | Imper        NumPersI
   | Ger
   | Part  TempoP Gender   Number ;

-- This is the full verb type.

oper Verbum = {s : VForm => Str} ;
}
