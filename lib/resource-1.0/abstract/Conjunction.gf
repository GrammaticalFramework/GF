abstract Conjunction = Cat ** {

  fun

    ConjS    : Conj -> [S] -> S ;         -- "John walks and Mary runs"
    ConjAP   : Conj -> [AP] -> AP ;       -- "even and prime"
    ConjNP   : Conj -> [NP] -> NP ;       -- "John or Mary"
    ConjAdv  : Conj -> [Adv] -> Adv ;     -- "quickly or slowly"

    DConjS   : DConj -> [S] -> S ;        -- "either John walks or Mary runs"
    DConjAP  : DConj -> [AP] -> AP ;      -- "both even and prime"
    DConjNP  : DConj -> [NP] -> NP ;      -- "either John or Mary"
    DConjAdv : DConj -> [Adv] -> Adv ;    -- "both badly and slowly"

-- These categories are internal to this module.

  cat
    [S]{2} ; 
    [Adv]{2} ; 
    [NP]{2} ; 
    [AP]{2} ;

}
