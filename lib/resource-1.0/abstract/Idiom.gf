--1 Idiomatic expressions

abstract Idiom = Cat ** {

-- This module defines constructions that are formed in fixed ways,
-- often different even in closely related languages.

  fun
    ImpersCl  : VP -> Cl ;    -- it rains
    GenericCl : VP -> Cl ;    -- one sleeps

    ExistNP   : NP -> Cl ;    -- there is a house
    ExistIP   : IP -> QCl ;   -- which houses are there

    ProgrVP   : VP -> VP ;    -- be sleeping

}
