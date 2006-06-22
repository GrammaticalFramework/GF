--1 Conjunction: Coordination

-- Coordination is defined for many different categories; here is
-- a sample. The rules apply to *lists* of two or more elements,
-- and define two general patterns: 
-- - ordinary conjunction: X,...X and X
-- - distributed conjunction: both X,...,X and X
--
--
-- $VP$ conjunctions are not covered here, because their applicability
-- depends on language. Some special cases are defined in 
-- [``Extra`` ../abstract/Extra.gf].


abstract Conjunction = Cat ** {

--2 Rules

  fun
    ConjS    : Conj -> [S] -> S ;     -- "John walks and Mary runs"
    ConjAP   : Conj -> [AP] -> AP ;   -- "even and prime"
    ConjNP   : Conj -> [NP] -> NP ;   -- "John or Mary"
    ConjAdv  : Conj -> [Adv] -> Adv ; -- "quickly or slowly"

    DConjS   : DConj -> [S] -> S ;    -- "either John walks or Mary runs"
    DConjAP  : DConj -> [AP] -> AP ;  -- "both even and prime"
    DConjNP  : DConj -> [NP] -> NP ;  -- "either John or Mary"
    DConjAdv : DConj -> [Adv] -> Adv; -- "both badly and slowly"

--2 Categories

-- These categories are only used in this module.

  cat
    [S]{2} ; 
    [Adv]{2} ; 
    [NP]{2} ; 
    [AP]{2} ;

--2 List constructors

-- The list constructors are derived from the list notation and therefore
-- not given explicitly. But here are their type signatures:

  --  BaseC : C -> C   -> [C] ;  -- for C = S, AP, NP, Adv
  --  ConsC : C -> [C] -> [C] ;
}

--.
-- *Note*. This module uses right-recursive lists. If backward
-- compatibility with API 0.9 is needed, use
-- [SeqConjunction SeqConjunction.html].
