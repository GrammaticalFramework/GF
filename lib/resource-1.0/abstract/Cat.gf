--1 The category system

abstract Cat = Tense ** {

  cat

--2 Top-level units

-- Constructed in [Phrase Phrase.html].

    Text ;  -- text consisting of several phrases
    Phr ;   -- phrase in a text                    e.g. "But be quiet my darling."
    Utt ;   -- sentence, question, word...         e.g. "be quiet"
    Voc ;   -- vocative or "please"                e.g. "my darling"

--2 Sentences and clauses

-- Constructed in [Sentence Sentence.html].

    S ;     -- declarative sentence                e.g. "she lived here"
    QS ;    -- question                            e.g. "where did she live"
    RS ;    -- relative                            e.g. "in which she lived"
    Cl ;    -- declarative clause, with all tenses e.g. "she looks at this"
    Slash ; -- clause missing NP (S/NP in GPSG)    e.g. "she looks at"
    Imp ;   -- imperative                          e.g. "look at this"
    SC ;    -- embedded sentence or question       e.g. "that it rains"

--2 Questions and interrogatives

-- Constructed in [Question Question.html].

    QCl ;   -- question clause, with all tenses    e.g. "why does she walk"
    IP ;    -- interrogative pronoun               e.g. "who"
    IAdv ;  -- interrogative adverb                e.g. "why"
    IDet ;  -- interrogative determiner            e.g. "which"

--2 Relative clauses and pronouns

-- Constructed in [Relative Relative.html].

    RCl ;   -- relative clause, with all tenses    e.g. "in which she lives"
    RP ;    -- relative pronoun                    e.g. "in which"

--2 Verb phrases

-- Constructed in [Verb Verb.html].

    VP ;    -- verb phrase                         e.g. "is very warm"
    Comp ;  -- complement of copula, such as AP    e.g. "very warm"

--2 Adjectival phrases

-- Constructed in [Adjective Adjective.html].

    AP ;    -- adjectival phrase                   e.g. "very warm"

--2 Nouns and noun phrases

-- Constructed in [Noun Noun.html]. 
-- Many atomic noun phrases e.g. "everybody"
-- are constructed in [Structural Structural.html].
-- The determiner structure is
-- ``` Predet (QuantSg | QuantPl Num) Ord
-- as defined in [Noun Noun.html].

    CN ;    -- common noun (without determiner)    e.g. "red house"
    NP ;    -- noun phrase (subject or object)     e.g. "the red house"
    Pron ;  -- personal pronoun                    e.g. "she"
    Det ;   -- determiner phrase                   e.g. "all the seven"
    Predet; -- predeterminer (prefixed Quant)      e.g. "all"
    QuantSg;-- quantifier ('nucleus' of sing. Det) e.g. "this"
    QuantPl;-- quantifier ('nucleus' of plur. Det) e.g. "these"
    Num ;   -- cardinal number (used with QuantPl) e.g. "seven"
    Ord ;   -- ordinal number (used in Det)        e.g. "seventh"

--2 Adverbs

-- Constructed in [Adverb Adverb.html].  
-- Many adverbs are constructed in [Structural Structural.html].

    Adv ;   -- verb-phrase-modifying adverb,       e.g. "in the house"
    AdV ;   -- adverb directly attached to verb    e.g. "always"
    AdA ;   -- adjective-modifying adverb,         e.g. "very"
    AdN ;   -- numeral-modifying adverb,           e.g. "more than"

--2 Numerals

-- Constructed in [Numeral Numeral.html].

    Numeral;-- cardinal or ordinal,                e.g. "five/fifth"

--2 Structural words

-- Constructed in [Structural Structural.html].

    Conj ;  -- conjunction,                        e.g. "and"
    DConj ; -- distributed conj.                   e.g. "both - and"
    PConj ; -- phrase-beginning conj.              e.g. "therefore"
    CAdv ;  -- comparative adverb                  e.g. "more"
    Subj ;  -- subjunction,                        e.g. "if"
    Prep ;  -- preposition, or just case           e.g. "in"

--2 Words of open classes

-- These are constructed in [Lexicon Lexicon.html] and in additional lexicon modules.

    V ;     -- one-place verb                      e.g. "sleep" 
    V2 ;    -- two-place verb                      e.g. "love"
    V3 ;    -- three-place verb                    e.g. "show"
    VV ;    -- verb-phrase-complement verb         e.g. "want"
    VS ;    -- sentence-complement verb            e.g. "claim"
    VQ ;    -- question-complement verb            e.g. "ask"
    VA ;    -- adjective-complement verb           e.g. "look"
    V2A ;   -- verb with NP and AP complement      e.g. "paint"

    A ;     -- one-place adjective                 e.g. "warm"
    A2 ;    -- two-place adjective                 e.g. "divisible"

    N ;     -- common noun                         e.g. "house"
    N2 ;    -- relational noun                     e.g. "son"
    N3 ;    -- three-place relational noun         e.g. "connection"
    PN ;    -- proper name                         e.g. "Paris"

}
