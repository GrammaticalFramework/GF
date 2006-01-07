abstract Cat = {

  cat

-- Top-level units constructed in $Phrase$.

    Text ;  -- text consisting of several phrases
    Phr ;   -- phrase in a text                            e.g. "But be quiet my darling."
    Utt ;   -- sentence, question, "one-word utterance"... e.g. "be quiet"
    Voc ;   -- vocative or "please"                        e.g. "my darling"

-- Tensed sentences constructed in $Tensed$ and, with just present forms, in $Untensed$.

    S ;     -- declarative sentence                        e.g. "she lived here"
    QS ;    -- question                                    e.g. "where did she live"
    RS ;    -- relative                                    e.g. "in which she lived"

-- Clauses constructed in $Sentence$.

    Cl ;    -- declarative clause, with all tense forms    e.g. "she looks at this"
    Slash ; -- clause lacking object (S/NP in GPSG)        e.g. "she looks at"
    Imp ;   -- imperative                                  e.g. "look at this"

-- Questions and interrogatives, constructed in $Question$.

    QCl ;   -- question clause, with all tense forms       e.g. "why does she walk"
    IP ;    -- interrogative pronoun                       e.g. "who"
    IAdv ;  -- interrogative adverb                        e.g. "why"
    IDet ;  -- interrogative determiner                    e.g. "which"

-- Relatives, constructed in $Relative$.

    RCl ;   -- relative clause, with all tense forms       e.g. "in which she lives"
    RP ;    -- relative pronoun                            e.g. "in which"

-- Verb phrases, constructed in $Verb$.

    VP ;    -- verb phrase                                 e.g. "is very warm"
    Comp ;  -- complement of copula, e.g. AP, NP           e.g. "very warm"
    SC ;    -- sentential noun phrase: e.g. 'that' clause  e.g. "that it rains"

-- Adjectival phrases, constructed in $Adjective$.

    AP ;    -- adjectival phrase                           e.g. "very warm"

-- Nouns and noun phrases, constructed in $Noun$ (many also in $Structural$).

    CN ;    -- common noun (needs determiner to make NP)   e.g. "red house"
    NP ;    -- noun phrase (usable as subject or object)   e.g. "the red house"
    Pron ;  -- personal pronoun                            e.g. "she"
    Det ;   -- determiner phrase                           e.g. "all the seven"
    Predet; -- predeterminer (prefixed to a quantifier)    e.g. "all"
    Quant ; -- quantifier (the 'kernel' of a determiner)   e.g. "the"
    Num ;   -- cardinal number (used in a determiner)      e.g. "seven"
    Ord ;   -- ordinal number (used in a determiner)       e.g. "first"

-- Adverbs, constructed in $Adverb$  (many also in $Structural$).

    Adv ;   -- verb-phrase-modifying adverb,               e.g. "in the house"
    AdV ;   -- sentential adverb, typically close to verb  e.g. "always"
    AdA ;   -- adjective-modifying adverb,                 e.g. "very"
    AdN ;   -- numeral-modifying adverb,                   e.g. "more than"

-- Numeral with cardinal and ordinal forms, constructed in $Numeral$.

    Numeral;-- cardinal or ordinal,                        e.g. "five/fifth"

-- Structural words, constructed in $Structural$.

    Conj ;  -- conjunction,                                e.g. "and"
    DConj ; -- distributed conj.                           e.g. "both - and"
    PConj ; -- phrase-beginning conj.                      e.g. "therefore"
    CAdv ;  -- comparative adverb                          e.g. "more"
    Subj ;  -- subjunction,                                e.g. "if"
    Prep ;  -- preposition, or just a case in some langs   e.g. "in"

-- Words of open classes, constructed in $Basic$ and in additional lexicon modules.

    V ;     -- one-place verb                              e.g. "sleep" 
    V2 ;    -- two-place verb                              e.g. "love"
    V3 ;    -- three-place verb                            e.g. "show"
    VV ;    -- verb-phrase-complement verb                 e.g. "want"
    VS ;    -- sentence-complement verb                    e.g. "claim"
    VQ ;    -- question-complement verb                    e.g. "ask"
    VA ;    -- adjective-complement verb                   e.g. "look"
    V2A ;   -- verb with NP and AP complement              e.g. "paint"

    A ;     -- one-place adjective                         e.g. "warm"
    A2 ;    -- two-place adjective                         e.g. "divisible"

    N ;     -- common noun                                 e.g. "house"
    N2 ;    -- relational noun                             e.g. "son"
    N3 ;    -- three-place relational noun                 e.g. "connection"
    PN ;    -- proper name                                 e.g. "Paris"

}
