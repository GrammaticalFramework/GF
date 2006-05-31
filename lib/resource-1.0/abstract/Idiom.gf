--1 Idiomatic expressions

abstract Idiom = Cat ** {

-- This module defines constructions that are formed in fixed ways,
-- often different even in closely related languages.

  fun
    ImpersCl  : VP -> Cl ;        -- it rains
    GenericCl : VP -> Cl ;        -- one sleeps

    CleftNP   : NP  -> RS -> Cl ; -- it is you who did it
    CleftAdv  : Adv -> S  -> Cl ; -- it is yesterday she arrived

    ExistNP   : NP -> Cl ;        -- there is a house
    ExistIP   : IP -> QCl ;       -- which houses are there

    ProgrVP   : VP -> VP ;        -- be sleeping

    ImpPl1    : VP -> Utt ;       -- let's go

}
