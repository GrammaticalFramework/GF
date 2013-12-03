--1 Idiom: Idiomatic Expressions

abstract Idiom = Cat ** {

-- This module defines constructions that are formed in fixed ways,
-- often different even in closely related languages.

  fun
    ImpersCl  : VP -> Cl ;        -- it is hot
    GenericCl : VP -> Cl ;        -- one sleeps

    CleftNP   : NP  -> RS -> Cl ; -- it is I who did it
    CleftAdv  : Adv -> S  -> Cl ; -- it is here she slept

    ExistNP   : NP -> Cl ;        -- there is a house
    ExistIP   : IP -> QCl ;       -- which houses are there

-- 7/12/2012 generalizations of these

    ExistNPAdv : NP -> Adv -> Cl ;    -- there is a house in Paris
    ExistIPAdv : IP -> Adv -> QCl ;   -- which houses are there in Paris

    ProgrVP   : VP -> VP ;        -- be sleeping

    ImpPl1    : VP -> Utt ;       -- let's go

    ImpP3     : NP -> VP -> Utt ; -- let John walk

-- 3/12/2013 non-reflexive uses of "self"

    SelfAdvVP : VP -> VP ;        -- is at home himself
    SelfAdVVP : VP -> VP ;        -- is himself at home
    SelfNP    : NP -> NP ;        -- the president himself (is at home)

}
