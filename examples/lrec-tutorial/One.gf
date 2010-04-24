abstract One = {
  cat  
    S ;
    Cl ; 
    NP ; 
    VP ;
    AP ;
    CN ;
    Det ;
    Pron ;
    PN ;
    N ;
    A ;
    V ;
    V2 ;
    Adv ;
    Prep ;
    Pol ;
    Tense ;
  fun
    DeclCl  : Tense -> Pol -> Cl -> S ;
    QuestCl : Tense -> Pol -> Cl -> S ;

    PredVP  : NP -> VP -> Cl ;

    ComplV2 : V2 -> NP -> VP ;
    UseAP   : AP -> VP ;
    UseV    : V -> VP ;
    AdVP    : VP -> Adv -> VP ;

    DetCN   : Det -> CN -> NP ;
    UsePN   : PN -> NP ;
    UsePron : Pron -> NP ;

    ModCN   : CN -> AP -> CN ;
    UseN    : N -> CN ;

    UseA    : A -> AP ;

    AdvA    : A -> Adv ;
    PrepNP  : Prep -> NP -> Adv ;
}
