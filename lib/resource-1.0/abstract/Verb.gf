abstract Verb = Cat ** {

  fun
    UseV    : V -> VP ;
    ComplV2 : V2 -> NP -> VP ;
    ComplV3 : V3 -> NP -> NP -> VP ;

    ComplVV : VV -> VP -> VP ;
    ComplVS : VS -> S  -> VP ;
    ComplVQ : VQ -> QS -> VP ;

    ComplVA : VA -> AP -> VP ;
    ComplV2A : V2A -> NP -> AP -> VP ;

    ReflV2  : V2 -> VP ;
    PassV2  : V2 -> Comp ; --- overgen (V2 with prep)

    UseComp : Comp -> VP ;

    AdvVP   : VP -> Adv -> VP ; -- here
    AdVVP   : AdV -> VP -> VP ; -- always

    CompAP  : AP  -> Comp ;
    CompNP  : NP  -> Comp ;
    CompAdv : Adv -> Comp ;

    UseVV   : VV -> V2 ;
    UseVQ   : VQ -> V2 ;
    UseVS   : VS -> V2 ;

    EmbedS  : S  -> SC ;
    EmbedQS : QS -> SC ;
    EmbedVP : VP -> SC ;


}
