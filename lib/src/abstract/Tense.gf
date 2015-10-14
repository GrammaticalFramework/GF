--1 Common: Structures with Common Implementations.

-- This module defines the abstract parameters of tense, polarity, and
-- anteriority, which are used in [``Phrase`` Phrase.html] to generate different
-- forms of sentences. Together they give 4 x 2 x 2 = 16 sentence forms.

-- These tenses are defined for all languages in the library. More tenses
-- can be defined in the language extensions, e.g. the "passe simple" of
-- Romance languages in [``ExtraRomance`` ../romance/ExtraRomance.gf].

abstract Tense = Common ** {

  fun
    TTAnt : Tense -> Ant -> Temp ;  -- [combination of tense and anteriority, e.g. past anterior]

    PPos : Pol ;           -- I sleep  [positive polarity]
    PNeg : Pol ;           -- I don't sleep [negative polarity]

    TPres  : Tense ;             -- I sleep/have slept [present]  
    ASimul : Ant ;               -- I sleep/slept [simultaneous, not compound]
    TPast  : Tense ;             -- I slept [past, "imperfect"]      --# notpresent
    TFut   : Tense ;             -- I will sleep [future] --# notpresent
    TCond  : Tense ;             -- I would sleep [conditional] --# notpresent
    AAnter : Ant ;               -- I have slept/had slept [anterior, "compound", "perfect"] --# notpresent
}
