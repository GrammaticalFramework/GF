-- Structures special for Italian. These are not implemented in other
-- Romance languages.

abstract ExtraItaAbs = ExtraRomanceAbs ** {

  fun

-- Feminine variants of pronouns (those in $Structural$ are
-- masculine, which is the default when gender is unknown).

    i8fem_Pron : Pron ;
    these8fem_NP : NP ;
    they8fem_Pron : Pron ;
    this8fem_NP : NP ;
    those8fem_NP : NP ;

    we8fem_Pron : Pron ;
    whoPl8fem_IP : IP ;
    whoSg8fem_IP : IP ;

    youSg8fem_Pron : Pron ;
    youPl8fem_Pron : Pron ;
    youPol8fem_Pron : Pron ;  -- Lei

    youPolPl_Pron : Pron ;    -- Loro
    youPolPl8fem_Pron : Pron ;

-- Possessive without definite article, like "mio figlio".

    PossFamQuant : Pron -> Quant ;
}
