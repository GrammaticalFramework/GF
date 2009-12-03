--1 Common: Structures with Common Implementations.

-- This module defines the abstract parameters of tense, polarity, and
-- anteriority, which are used in [``Phrase`` Phrase.html] to generate different
-- forms of sentences. Together they give 4 x 2 x 2 = 16 sentence forms.

-- These tenses are defined for all languages in the library. More tenses
-- can be defined in the language extensions, e.g. the "passé simple" of
-- Romance languages in [``ExtraRomance`` ../romance/ExtraRomance.gf].

abstract Tense = Common ** {

  fun
    TTAnt : Tense -> Ant -> Temp ;

    PPos, PNeg : Pol ;           -- I sleep/don't sleep

    TPres  : Tense ;                
    ASimul : Ant ;
    TPast, TFut, TCond : Tense ; -- I slept/will sleep/would sleep --# notpresent
    AAnter : Ant ;               -- I have slept                   --# notpresent
}
