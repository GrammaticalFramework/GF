abstract Fun = Cat ** {
  fun
    Pred : NP -> VP -> Cl ;
    
    UseV    : V -> VP ;
    ComplV2 : V2 -> NP -> VP ;
    ComplVV : VV -> VP -> VP ;
    UseComp : Comp -> VP ;
    AdvVP   : VP -> Adv -> VP ;

    UseVV   : VV -> V2 ;

    CompAP  : AP  -> Comp ;
    CompNP  : NP  -> Comp ;
    CompAdv : Adv -> Comp ;

}
