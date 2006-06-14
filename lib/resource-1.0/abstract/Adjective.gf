--1 Adjective: Adjectives and Adjectival Phrases

abstract Adjective = Cat ** {

  fun

-- The principal ways of forming an adjectival phrase are
-- positive, comparative, relational, reflexive-relational, and
-- elliptic-relational.
-- (The superlative use is covered in [Noun Noun.html].$SuperlA$.)

    PositA  : A -> AP ;         -- warm
    ComparA : A -> NP -> AP ;   -- warmer than Spain
    ComplA2 : A2 -> NP -> AP ;  -- divisible by 2
    ReflA2  : A2 -> AP ;        -- divisible by itself
    UseA2   : A2 -> A ;         -- divisible

-- Sentence and question complements defined for all adjectival
-- phrases, although the semantics is only clear for some adjective.
 
    SentAP  : AP -> SC -> AP ;  -- great that she won, uncertain if she did

-- An adjectival phrase can be modified by an *adadjective*, such as "very".

    AdAP    : AdA -> AP -> AP ; -- very uncertain

-- The formation of adverbs from adjective (e.g. "quickly") is covered
-- by [Adverb Adverb.html].

}
