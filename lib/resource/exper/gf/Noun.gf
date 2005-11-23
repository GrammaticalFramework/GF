abstract Noun = Cat ** {

  fun
    DetCN   : Det -> CN -> NP ;
    UsePN   : PN -> NP ;
    UsePron : Pron -> NP ;

    MkDet : Predet -> Quant -> Num -> Det ;
    
    PossPronSg, PossPronPl : Pron -> Quant ; --- PossNP not in romance

    NoNum  : Num ;
    NumInt : Int -> Num ;

    NoPredet : Predet ;

    DefSg, DefPl : Quant ;
    IndefSg, IndefPl : Quant ;


--    Num_Pl ::= Ordinal ;
--    Num_Pl ::= Numeral ;

    ComplN2 : N2 -> NP -> CN ;
    ComplN3 : N3 -> NP -> N2 ;

    AdjCN   : AP -> CN -> CN ;
    SentCN  : CN -> S  -> CN ;
    QuestCN : CN -> QS -> CN ;

    UseN : N -> CN ;

-- structural

    only_Predet : Predet ;
    this_Quant  : Quant ;

} ;
