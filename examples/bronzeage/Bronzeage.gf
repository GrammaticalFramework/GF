abstract Bronzeage = Swadesh ** {

  flags startcat = Phr ; 

  cat
    Phr ;
    Imp ;
    Cl ;
    CN ;

    V ;
    V2 ;
    V3 ;
    A ;
    Pron ;
    Det ;
    Card ;
    Prep ;

    MassCN ;

  fun
    PhrPos    : Cl -> Phr ;
    PhrNeg    : Cl -> Phr ;
    PhrQuest  : Cl -> Phr ;
    PhrIAdv   : IAdv -> Cl -> Phr ;
    PhrImp    : Imp -> Phr ;    
    PhrImpNeg : Imp -> Phr ;    

    SentV  : V  -> NP -> Cl ;
    SentV2 : V2 -> NP -> NP -> Cl ;
    SentV2Mass : V2 -> NP -> MassCN -> Cl ;
    SentV3 : V3 -> NP -> NP -> NP -> Cl ;
    SentA  : A  -> NP -> Cl ;
    SentNP : NP -> NP -> Cl ;

    SentAdvV  : V  -> NP -> Adv -> Cl ;
    SentAdvV2 : V2 -> NP -> NP -> Adv -> Cl ;

    ImpV  : V -> Imp ;
    ImpV2 : V2 -> NP -> Imp ;

    DetCN : Det -> CN -> NP ;
    NumCN : Card -> CN -> NP ;

    UseN  : N -> CN ;
    ModCN : A -> CN -> CN ;

    UseMassN : MassN -> MassCN ;
    ModMass : A -> MassCN -> MassCN ;

-- new
    DefCN : CN -> NP ;
    IndefCN : CN -> NP ;
    PrepNP : Prep -> NP -> Adv ;
    on_Prep : Prep ;

}
