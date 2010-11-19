--1 Adverb: Adverbs and Adverbial Phrases

abstract Adverb = Cat ** {

  fun

-- The two main ways of forming adverbs are from adjectives and by
-- prepositions from noun phrases.

    PositAdvAdj : A -> Adv ;                 -- warmly
    PrepNP      : Prep -> NP -> Adv ;        -- in the house

-- Comparative adverbs have a noun phrase or a sentence as object of
-- comparison.

    ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
    ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs

-- Adverbs can be modified by 'adadjectives', just like adjectives.

    AdAdv  : AdA -> Adv -> Adv ;             -- very quickly

-- Like adverbs, adadjectives can be produced by adjectives.

    PositAdAAdj : A -> AdA ;                 -- extremely

-- Subordinate clauses can function as adverbs.

    SubjS  : Subj -> S -> Adv ;              -- when she sleeps

-- Comparison adverbs also work as numeral adverbs.

    AdnCAdv : CAdv -> AdN ;                  -- less (than five)

}
