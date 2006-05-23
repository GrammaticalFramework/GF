--1 Adverbs and adverbial phrases

abstract Adverb = Cat ** {

  fun

-- The two main ways of forming adverbs are from adjectives and by
-- prepositions from noun phrases.

    PositAdvAdj : A -> Adv ;                 -- quickly
    PrepNP      : Prep -> NP -> Adv ;        -- in the house

-- Comparative adverbs have a noun phrase or a sentence as object of
-- comparison.

    ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more quickly than John
    ComparAdvAdjS : CAdv -> A -> S -> Adv ;  -- more quickly than he runs

-- Adverbs can be modified by 'adadjectives', just like adjectives.

    AdAdv  : AdA -> Adv -> Adv ;             -- very quickly

-- Subordinate clauses can function as adverbs.

    SubjS : Subj -> S -> Adv ;               -- when he arrives
    AdvSC : SC -> Adv ;                      -- that he arrives ---- REMOVE?

-- Comparison adverbs also work as numeral adverbs.

    AdnCAdv : CAdv -> AdN ;                  -- more (than five)


}
