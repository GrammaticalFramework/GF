abstract Verb = Cat ** {

  fun
    UseV    : V -> VP ;
    ComplV2 : V2 -> NP -> VP ;
    ComplV3 : V3 -> NP -> NP -> VP ;
    ComplVV : VV -> VP -> VP ;
    ComplVS : VS -> S  -> VP ;
    ComplVQ : VQ -> QS -> VP ;

    ReflV2 : V2 -> VP ;
    PassV2 : V2 -> Comp ; --- overgen (V2 with prep)

    UseComp : Comp -> VP ;

    AdvVP   : VP -> Adv -> VP ; -- here
    AdVVP   : AdV -> VP -> VP ; -- always

    UseVV   : VV -> V2 ;
    UseVQ   : VQ -> V2 ;
    UseVS   : VS -> V2 ;

    CompAP  : AP  -> Comp ;
    CompNP  : NP  -> Comp ;
    CompAdv : Adv -> Comp ;

}
