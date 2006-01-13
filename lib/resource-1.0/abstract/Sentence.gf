abstract Sentence = Cat ** {

  fun

    PredVP   : NP -> VP -> Cl ;
    PredSCVP : SC -> VP -> Cl ;

    ImpVP    : VP -> Imp ;

    SlashV2   : NP -> V2 -> Slash ;
    SlashVVV2 : NP -> VV -> V2 -> Slash ;
    AdvSlash  : Slash -> Adv -> Slash ;
    SlashPrep : Cl -> Prep -> Slash ;

    EmbedS  : S  -> SC ;
    EmbedQS : QS -> SC ;
    EmbedVP : VP -> SC ;

}
