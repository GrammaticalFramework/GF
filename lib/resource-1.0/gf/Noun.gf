--1 The construction of nouns, noun phrases, and determiners

abstract Noun = Cat ** {

  fun
    DetCN   : Det -> CN -> NP ;
    UsePN   : PN -> NP ;
    UsePron : Pron -> NP ;

-- Determiner structure à la CLE; we further divide $Num$ into cardinal
-- and ordinal/superlative. So we get e.g. "my first forty books".

    MkDet : Predet -> Quant -> Num -> Ord -> Det ;
    
    PossPronSg, PossPronPl : Pron -> Quant ; --- PossNP not in romance

    NoNum  : Num ;
    NumInt : Int -> Num ;
    NumNumeral : Numeral -> Num ;

    AdNum : AdN -> Num -> Num ;

    OrdNumeral  : Numeral -> Ord ;
    
    NoOrd : Ord ;
    OrdSuperl : A -> Ord ;

    NoPredet : Predet ;

    DefSg,   DefPl   : Quant ;
    IndefSg, IndefPl : Quant ;

    ComplN2 : N2 -> NP -> CN ;
    ComplN3 : N3 -> NP -> N2 ;

    AdjCN   : AP -> CN -> CN ;
    RelCN   : CN -> RS -> CN ;

    SentCN  : CN -> S  -> CN ;
    QuestCN : CN -> QS -> CN ;

    UseN : N -> CN ;

} ;
