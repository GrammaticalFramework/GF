--1 Infrastructure with common implementations.

-- This module defines the abstract parameters of tense, polarity, and
-- anteriority, which are used in [Phrase Phrase.html] to generate different
-- forms of sentences. Together they give 2 x 4 x 4 = 16 sentence forms.

-- These tenses are defined for all languages in the library. More tenses
-- can be defined in the language extensions, e.g. the "passé simple" of
-- Romance languages.

abstract Common = {

  cat
    Text ;   -- text consisting of several phrases
    Phr ;    -- phrase in a text                    e.g. "But come here my darling."

    Pol ;
    Tense ;
    Ant ;

  fun
    PPos, PNeg : Pol ;             -- I sleep/don't sleep

    TPres  : Tense ;                
    ASimul : Ant ;
    TPast, TFut, TCond : Tense ;   -- I slept/will sleep/would sleep --# notpresent
    AAnter : Ant ;                 -- I have slept                   --# notpresent

}
