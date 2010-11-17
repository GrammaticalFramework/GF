--1 Common: Structures with Common Implementations.

-- This module defines the categories that uniformly have the linearization
-- ${s : Str}$ in all languages. 

abstract Common = {

  cat

--2 Top-level units

-- Constructed in [``Text`` Text.html]: $Text$.

    Text ;  -- text consisting of several phrases  e.g. "He is here. Why?"

-- Constructed in [``Phrase`` Phrase.html]:

    Phr ;    -- phrase in a text                   e.g. "but be quiet please"
    Utt ;    -- sentence, question, word...        e.g. "be quiet"
    Voc ;    -- vocative or "please"               e.g. "my darling"
    PConj ;  -- phrase-beginning conjunction       e.g. "therefore"
    Interj ; -- interjection                       e.g. "alas"

-- Constructed in [``Sentence`` Sentence.html]:

    SC ;    -- embedded sentence or question       e.g. "that it rains"

--2 Adverbs

-- Constructed in [``Adverb`` Adverb.html].  
-- Many adverbs are constructed in [``Structural`` Structural.html].

    Adv ;   -- verb-phrase-modifying adverb        e.g. "in the house"
    AdV ;   -- adverb directly attached to verb    e.g. "always"
    AdA ;   -- adjective-modifying adverb          e.g. "very"
    AdN ;   -- numeral-modifying adverb            e.g. "more than"
    IAdv ;  -- interrogative adverb                e.g. "why"
    CAdv ;  -- comparative adverb                  e.g. "more"

--2 Tense, polarity, and anteriority

    Temp ;  -- temporal and aspectual features     e.g. past anterior
    Tense ; -- tense                               e.g. present, past, future
    Pol ;   -- polarity                            e.g. positive, negative
    Ant ;   -- anteriority                         e.g. simultaneous, anterior

}
