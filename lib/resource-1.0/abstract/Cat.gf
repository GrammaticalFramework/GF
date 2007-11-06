--1 Cat: the Category System

-- The category system is central to the library in the sense
-- that the other modules ($Adjective$, $Adverb$, $Noun$, $Verb$ etc)
-- communicate through it. This means that a e.g. a function using
-- $NP$s in $Verb$ need not know how $NP$s are constructed in $Noun$:
-- it is enough that both $Verb$ and $Noun$ use the same type $NP$,
-- which is given here in $Cat$.
-- 
-- Some categories are inherited from [``Common`` Common.html].
-- The reason they are defined there is that they have the same
-- implementation in all languages in the resource (typically,
-- just a string). These categories are
-- $AdA, AdN, AdV, Adv, Ant, CAdv, IAdv, PConj, Phr$, 
-- $Pol, SC, Tense, Text, Utt, Voc$.
--
-- Moreover, the list categories $ListAdv, ListAP, ListNP, ListS$
-- are defined on $Conjunction$ and only used locally there.


abstract Cat = Common ** {

  cat

--2 Sentences and clauses

-- Constructed in [Sentence Sentence.html], and also in
-- [Idiom Idiom.html].

    S ;     -- declarative sentence                e.g. "she lived here"
    QS ;    -- question                            e.g. "where did she live"
    RS ;    -- relative                            e.g. "in which she lived"
    Cl ;    -- declarative clause, with all tenses e.g. "she looks at this"
    Slash ; -- clause missing NP (S/NP in GPSG)    e.g. "she looks at"
    SlashS ;-- sentence missing NP                 e.g. "she has looked at"
    Imp ;   -- imperative                          e.g. "look at this"

--2 Questions and interrogatives

-- Constructed in [Question Question.html].

    QCl ;   -- question clause, with all tenses    e.g. "why does she walk"
    IP ;    -- interrogative pronoun               e.g. "who"
    IComp ; -- interrogative complement of copula  e.g. "where"
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

    CN ;     -- common noun (without determiner)    e.g. "red house"
    NP ;     -- noun phrase (subject or object)     e.g. "the red house"
    Pron ;   -- personal pronoun                    e.g. "she"
    Det ;    -- determiner phrase                   e.g. "those seven"
    Predet ; -- predeterminer (prefixed Quant)      e.g. "all"
    QuantSg ;-- quantifier ('nucleus' of sing. Det) e.g. "every"
    QuantPl ;-- quantifier ('nucleus' of plur. Det) e.g. "many"
    Quant ;  -- quantifier with both sg and pl      e.g. "this/these"
    Num ;    -- cardinal number (used with QuantPl) e.g. "seven"
    Ord ;    -- ordinal number (used in Det)        e.g. "seventh"

--2 Numerals

-- Constructed in [Numeral Numeral.html].

    Numeral;-- cardinal or ordinal,                e.g. "five/fifth"

--2 Structural words

-- Constructed in [Structural Structural.html].

    Conj ;  -- conjunction                         e.g. "and"
    DConj ; -- distributed conjunction             e.g. "both - and"
    Subj ;  -- subjunction                         e.g. "if"
    Prep ;  -- preposition, or just case           e.g. "in"

--2 Words of open classes

-- These are constructed in [Lexicon Lexicon.html] and in 
-- additional lexicon modules.

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
