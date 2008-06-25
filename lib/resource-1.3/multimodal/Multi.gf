--1 Multimodal additions to the resource grammar library

abstract Multi = Lang ** {

  cat

-- Entrypoint for speech recognition - suppresses clicks.

    Speech ;

-- The entrypoint to sequencialized multimodal input is $Phr$.

-- The pointing gesture (click) type.

    Point ;

  fun

-- The top function to send an utterance to speech recognizer.

    SpeechUtt : PConj -> Utt -> Voc -> Speech ;

-- Demonstratives.

    this8point_NP : Point -> NP ;
    that8point_NP : Point -> NP ;
    these8point_NP : Point -> NP ;
    those8point_NP : Point -> NP ;
    here8point_Adv : Point -> Adv ;
    here7to8point_Adv : Point -> Adv ;
    here7from8point_Adv : Point -> Adv ;
    this8point_Quant : Point -> Quant ;
    that8point_Quant : Point -> Quant ;

-- Building points from strings.

    MkPoint : String -> Point ;

}
