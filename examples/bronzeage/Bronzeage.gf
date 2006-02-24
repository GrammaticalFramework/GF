abstract Bronzeage = Cat, Swadesh ** {

  cat
    Sent ;

  fun
    PhrPos    : Sent -> Phr ;
    PhrNeg    : Sent -> Phr ;
    PhrQuest  : Sent -> Phr ;
    PhrImp    : Imp  -> Phr ;    
    PhrImpNeg : Imp  -> Phr ;    

    SentV  : V  -> NP -> Sent ;
    SentV2 : V2 -> NP -> NP -> Sent ;
    SentV3 : V3 -> NP -> NP -> NP -> Sent ;
    SentA  : A  -> NP -> Sent ;
    SentNP : NP -> NP -> Sent ;

    SentAdvV  : V  -> NP -> Adv -> Sent ;
    SentAdvV2 : V2 -> NP -> NP -> Adv -> Sent ;

    ImpV  : V -> Imp ;
    ImpV2 : V2 -> NP -> Imp ;

    DetCN : Det -> CN -> NP ;
    NumCN : Num -> CN -> NP ;

    UseN  : N -> CN ;
    ModCN : A -> CN -> CN ;

}
