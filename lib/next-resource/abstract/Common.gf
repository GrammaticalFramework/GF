--1 Common: Structures with Common Implementations.

-- This module defines the categories that uniformly have the linearization
-- ${s : Str}$ in all languages. 

-- Moreover, this module defines the abstract parameters of tense, polarity, and
-- anteriority, which are used in [``Phrase`` Phrase.html] to generate different
-- forms of sentences. Together they give 4 x 2 x 2 = 16 sentence forms.

-- These tenses are defined for all languages in the library. More tenses
-- can be defined in the language extensions, e.g. the "passé simple" of
-- Romance languages in [``ExtraRomance`` ../romance/ExtraRomance.gf].

abstract Common = {

  cat

--2 Top-level units

-- Constructed in [``Text`` Text.html]: $Text$.

    Text ;  -- text consisting of several phrases  e.g. "He is here. Why?"

-- Constructed in [``Phrase`` Phrase.html]:

    Phr ;   -- phrase in a text                    e.g. "but be quiet please"
    Utt ;   -- sentence, question, word...         e.g. "be quiet"
    Voc ;   -- vocative or "please"                e.g. "my darling"
    PConj ; -- phrase-beginning conjunction        e.g. "therefore"

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

  fun
    TTAnt : Tense -> Ant -> Temp ;

    PPos, PNeg : Pol ;           -- I sleep/don't sleep

    TPres  : Tense ;                
    ASimul : Ant ;
    TPast, TFut, TCond : Tense ; -- I slept/will sleep/would sleep --# notpresent
    AAnter : Ant ;               -- I have slept                   --# notpresent

}
