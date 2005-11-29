abstract Conjunction = Sequence ** {

  fun

    ConjS    : Conj -> SeqS -> S ;        -- "John walks and Mary runs"
    ConjAP   : Conj -> SeqAP -> AP ;      -- "even and prime"
    ConjNP   : Conj -> SeqNP -> NP ;      -- "John or Mary"
    ConjAdv  : Conj -> SeqAdv -> Adv ;    -- "quickly or slowly"

    DConjS   : DConj -> SeqS -> S ;       -- "either John walks or Mary runs"
    DConjAP  : DConj -> SeqAP -> AP ;     -- "both even and prime"
    DConjNP  : DConj -> SeqNP -> NP ;     -- "either John or Mary"
    DConjAdv : DConj -> SeqAdv -> Adv ;   -- "both badly and slowly"

}
