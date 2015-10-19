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
    ConjS    : Conj -> ListS -> S ;       -- he walks and she runs
    ConjRS   : Conj -> ListRS -> RS ;     -- who walks and whose mother runs
    ConjAP   : Conj -> ListAP -> AP ;     -- cold and warm
    ConjNP   : Conj -> ListNP -> NP ;     -- she or we
    ConjAdv  : Conj -> ListAdv -> Adv ;   -- here or there
    ConjAdV  : Conj -> ListAdV -> AdV ;   -- always or sometimes
    ConjIAdv : Conj -> ListIAdv -> IAdv ; -- where and with whom
    ConjCN   : Conj -> ListCN -> CN ;     -- man and woman
    ConjDet  : Conj -> ListDAP -> Det ;   -- his or her

--2 Categories

-- These categories are only used in this module.

  cat
    [S]{2} ; 
    [RS]{2} ; 
    [Adv]{2} ;
    [AdV]{2} ;
    [NP]{2} ; 
    [AP]{2} ;
    [IAdv]{2} ;
    [CN] {2} ;
    [DAP] {2} ;

--2 List constructors

-- The list constructors are derived from the list notation and therefore
-- not given explicitly. But here are their type signatures:
{-
-- overview
    BaseC : C -> C   -> [C] ;  --- for C = AdV, Adv, AP, CN, Det, IAdv, NP, RS, S
    ConsC : C -> [C] -> [C] ;  --- for C = AdV, Adv, AP, CN, Det, IAdv, NP, RS, S

-- complete list

  BaseAP : AP -> AP -> ListAP ;       -- red, white
  ConsAP : AP -> ListAP -> ListAP ;   -- red, white, blue

  BaseAdV : AdV -> AdV -> ListAdV ;     -- always, sometimes
  ConsAdV : AdV -> ListAdV -> ListAdV ; -- always, sometimes, never

  BaseAdv : Adv -> Adv -> ListAdv ;     -- here, there
  ConsAdv : Adv -> ListAdv -> ListAdv ; -- here, there, everywhere

  BaseCN : CN -> CN -> ListCN ;      -- man, woman
  ConsCN : CN -> ListCN -> ListCN ;  -- man, woman, child

  BaseIAdv : IAdv -> IAdv -> ListIAdv ;     -- where, when
  ConsIAdv : IAdv -> ListIAdv -> ListIAdv ; -- where, when, why

  BaseNP : NP -> NP -> ListNP ;      -- John, Mary
  ConsNP : NP -> ListNP -> ListNP ;  -- John, Mary, Bill

  BaseRS : RS -> RS -> ListRS ;       -- who walks, whom I know
  ConsRS : RS -> ListRS -> ListRS ;   -- who wals, whom I know, who is here

  BaseS : S -> S -> ListS ;      -- John walks, Mary runs
  ConsS : S -> ListS -> ListS ;  -- John walks, Mary runs, Bill swims

-}
}

