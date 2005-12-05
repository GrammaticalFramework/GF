abstract SeqConjunction = Cat ** {

-- This module is for backward compatibility with API 0.9.
-- To be used instead of Conjunction.

  fun

    ConjS    : Conj -> SeqS -> S ;        -- "John walks and Mary runs"
    ConjAP   : Conj -> SeqAP -> AP ;      -- "even and prime"
    ConjNP   : Conj -> SeqNP -> NP ;      -- "John or Mary"
    ConjAdv  : Conj -> SeqAdv -> Adv ;    -- "quickly or slowly"

    DConjS   : DConj -> SeqS -> S ;       -- "either John walks or Mary runs"
    DConjAP  : DConj -> SeqAP -> AP ;     -- "both even and prime"
    DConjNP  : DConj -> SeqNP -> NP ;     -- "either John or Mary"
    DConjAdv : DConj -> SeqAdv -> Adv ;   -- "both badly and slowly"


-- these are rather uninteresting

    TwoS : S -> S -> SeqS ;
    AddS : SeqS -> S -> SeqS ;
    TwoAdv : Adv -> Adv -> SeqAdv ;
    AddAdv : SeqAdv -> Adv -> SeqAdv ;
    TwoNP : NP -> NP -> SeqNP ;
    AddNP : SeqNP -> NP -> SeqNP ;
    TwoAP : AP -> AP -> SeqAP ;
    AddAP : SeqAP -> AP -> SeqAP ;

-- we use right-associative lists instead of GF's built-in lists

  cat
    SeqS ; 
    SeqAdv ; 
    SeqNP ; 
    SeqAP ;

}
