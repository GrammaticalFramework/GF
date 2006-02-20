--1 Idiomatic expressions

abstract Idiom = Cat ** {

-- This module defines constructions that are formed in fixed ways,
-- often different even in closely related languages.

  fun
    ExistNP   : NP -> Cl ;    -- there is a house
    ImpersCl  : VP -> Cl ;    -- it rains
    GenericCl : VP -> Cl ;    -- one sleeps

    ProgrVP   : VP -> VP ;    -- sleeping

}
