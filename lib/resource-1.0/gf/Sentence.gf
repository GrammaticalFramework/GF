abstract Sentence = Cat ** {

  fun

    PredVP : NP -> VP -> Cl ;

    SlashV2 : NP -> V2 -> Slash ;

    AdvSlash : Slash -> Adv -> Slash ;

    SlashPrep : Cl -> Prep -> Slash ;
}
   
