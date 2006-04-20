abstract PeaceKeep = Cat, PeaceLex ** {

  cat
    Sent ; MassCN ;

  fun
    PhrPos    : Sent -> Phr ;
    PhrNeg    : Sent -> Phr ;
    PhrQuest  : Sent -> Phr ;
    PhrImp    : Imp  -> Phr ;    
    PhrImpNeg : Imp  -> Phr ;    

    QuestIP_V : V -> IP -> Phr ;
    QuestIP_V2 : V2 -> IP -> NP -> Phr ;
    QuestIP_V2Mass : V2 -> IP -> MassCN -> Phr ;
    QuestIP_A : A -> IP -> Phr ;
    QuestIAdv_V : V -> NP -> IAdv -> Phr ;
    QuestIAdv_V2 : V2 -> NP -> NP -> IAdv -> Phr ;

    SentV  : V  -> NP -> Sent ;
    SentV2 : V2 -> NP -> NP -> Sent ;
    SentV2Mass : V2 -> NP -> MassCN -> Sent ;
    SentV3 : V3 -> NP -> NP -> NP -> Sent ;
    SentA  : A  -> NP -> Sent ;
    SentNP : NP -> NP -> Sent ;

    SentAdvV  : V  -> NP -> Adv -> Sent ;
    SentAdvV2 : V2 -> NP -> NP -> Adv -> Sent ;

    ImpV  : V -> Imp ;
    ImpV2 : V2 -> NP -> Imp ;
    ImpV3 : V3 -> NP -> NP -> Imp ;

    UsePron : Pron -> NP ;
    PossPronCNSg : Pron -> CN -> NP ;
    PossPronCNPl : Pron -> CN -> NP ;
    DetCN : Det -> CN -> NP ;
    NumCN : Num -> CN -> NP ;

    UseN  : N -> CN ;
    ModCN : A -> CN -> CN ;

    UseMassN : MassN -> MassCN ;
    ModMass : A -> MassCN -> MassCN ;

}