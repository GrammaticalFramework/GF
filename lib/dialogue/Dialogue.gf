abstract Dialogue = {

  cat
    Phrase ;
    Sentence ;
    Command ;
    
    NP ; V ; V2 ; VV ; A ; PP ; IP ;

  fun
    PhrasePos   : Sentence -> Phrase ;
    PhraseNeg   : Sentence -> Phrase ;
    PhraseQuest : Sentence -> Phrase ;

    SentV  : V  -> NP       -> Sentence ;
    SentV2 : V2 -> NP -> NP -> Sentence ;
    SentA  : A  -> NP       -> Sentence ;
    SentPP : PP -> NP       -> Sentence ;

    ModSentV  : VV -> V  -> NP       -> Sentence ;
    ModSentV2 : VV -> V2 -> NP -> NP -> Sentence ;
    ModSentA  : VV -> A  -> NP       -> Sentence ;
    ModSentPP : VV -> PP -> NP       -> Sentence ;

    WhQuestV      : V  -> IP       -> Phrase ;
    WhQuestSubjV2 : V2 -> IP -> NP -> Phrase ;
    WhQuestObjV2  : V2 -> NP -> IP -> Phrase ;
    WhQuestA      : A  -> IP       -> Phrase ;
    WhQuestPP     : PP -> IP       -> Phrase ;

    CommV  : V        -> Phrase ;
    CommV2 : V2 -> NP -> Phrase ;
    CommA  : A        -> Phrase ;
    CommPP : PP       -> Phrase ;

-- to test

    testNP : NP ; testV : V ; testV2 : V2 ; testVV : VV ; testA : A ;
    testPP : PP ; testIP : IP ;

}
