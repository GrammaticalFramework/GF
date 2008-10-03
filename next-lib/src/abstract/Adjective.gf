--1 Adjective: Adjectives and Adjectival Phrases

abstract Adjective = Cat ** {

  fun

-- The principal ways of forming an adjectival phrase are
-- positive, comparative, relational, reflexive-relational, and
-- elliptic-relational.

    PositA  : A  -> AP ;        -- warm
    ComparA : A  -> NP -> AP ;  -- warmer than I
    ComplA2 : A2 -> NP -> AP ;  -- married to her
    ReflA2  : A2 -> AP ;        -- married to itself
    UseA2   : A2 -> AP ;        -- married
    UseComparA : A  -> AP ;     -- warmer

-- The superlative use is covered in $Ord$.

    AdjOrd  : Ord -> AP ;       -- warmest

-- Sentence and question complements defined for all adjectival
-- phrases, although the semantics is only clear for some adjectives.
 
    SentAP  : AP -> SC -> AP ;  -- good that she is here

-- An adjectival phrase can be modified by an *adadjective*, such as "very".

    AdAP    : AdA -> AP -> AP ; -- very warm

-- The formation of adverbs from adjective (e.g. "quickly") is covered
-- in [Adverb Adverb.html].

}
