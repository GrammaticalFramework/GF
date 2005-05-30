incomplete concrete DialogueI of Dialogue = open Prelude, Resource, Basic, DialogueParam in {

  lincat
    Phrase = {s : Str} ;
    Sentence = {s :  PhraseForm => Str} ;
    Command = {s : Str} ;

    NP = NP ; V = V ; V2 = V2 ; VV = VV ; A = A ; PP = PP ; IP = IP ;

  lin
    PhrasePos s = ss (s.s ! PPos) ;
    PhraseNeg s = ss (s.s ! PNeg) ;
    PhraseQuest s = ss (s.s ! PQuest) ;

    SentV  v np     = mkPhrase (SPredV np v) ;
    SentV2 v np obj = mkPhrase (SPredV2 np v obj) ;
    SentA  v np     = mkPhrase (SPredAP np (UseA v)) ;
    SentPP pp np    = mkPhrase (SPredAdv np (AdvPP pp)) ;

    ModSentV  m v np     = mkPhrase (SPredVV np m (IPredV  ASimul v)) ;
    ModSentV2 m v np obj = mkPhrase (SPredVV np m (IPredV2 ASimul v obj)) ;

    CommV  v     = ImperOne (PosImpVP (IPredV  ASimul v)) ;
    CommV2 v obj = ImperOne (PosImpVP (IPredV2 ASimul v obj)) ;

    WhQuestV      v  ip    = mkQuestion (QPredV   ip v) ;
    WhQuestSubjV2 v  ip np = mkQuestion (QPredV2  ip v np) ;
    WhQuestObjV2  v  np ip = mkQuestion (IntSlash ip (SlashV2 np v)) ;
    WhQuestA      v  ip    = mkQuestion (QPredAP  ip (UseA v)) ;
    WhQuestPP     pp ip    = mkQuestion (QPredAdv ip (AdvPP pp)) ;


-- test

    testNP = she_NP ; testV = walk_V ; testV2 = love_V2 ; testVV =
    want_VV ; 
    --- testA = PositADeg blue_A ;
    testPP = PrepNP in_Prep (DefOneNP (UseN city_N)) ; 
    testIP = who8one_IP ;


}
