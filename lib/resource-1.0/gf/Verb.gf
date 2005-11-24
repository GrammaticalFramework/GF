abstract Verb = Cat ** {

  fun
    UseV    : V -> VP ;
    ComplV2 : V2 -> NP -> VP ;
    ComplV3 : V3 -> NP -> NP -> VP ;
    ComplVV : VV -> VP -> VP ;
    ComplVS : VS -> S  -> VP ;
    ComplVQ : VQ -> QS -> VP ;
    UseComp : Comp -> VP ;
    AdvVP   : VP -> Adv -> VP ;

    UseVV   : VV -> V2 ;
    UseVQ   : VQ -> V2 ;
    UseVS   : VS -> V2 ;

    CompAP  : AP  -> Comp ;
    CompNP  : NP  -> Comp ;
    CompAdv : Adv -> Comp ;

}
