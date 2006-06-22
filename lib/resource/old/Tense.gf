--1 Tense, Polarity, and Anteriority

-- This module defines the abstract parameters of tense, polarity, and
-- anteriority, which are used in [Tensed Tensed.html] to generate different
-- forms of sentences. Together they give 2 x 4 x 4 = 16 sentence forms.

-- These tenses are defined for all languages in the library. More tenses
-- can be defined in the language extensions, e.g. the "passé simple" of
-- Romance languages.

abstract Tense = {

  cat
    Pol ;
    Tense ;
    Ant ;

  fun
    PPos, PNeg : Pol ;                  -- I sleep/don't sleep
    TPres, TPast, TFut, TCond : Tense ; -- I sleep/slept/will sleep/would sleep
    ASimul, AAnter : Ant ;              -- I sleep/have slept

}
