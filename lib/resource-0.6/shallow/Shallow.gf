-- Shallow.gf by AR 19/2/2004
--
-- This is a resource API for shallow parsing.
-- It aims to be as unambiguous as possible: so it hides
-- scope ambiguities.
-- Therefore it has many more rules than would be necessary
-- actually to define the language.
-- It is not primarily aimed to be used through selection from the API,
-- but through a parser.
-- It can also serve for experiments with shallow (fast?) parsing.

abstract Shallow = {
  cat
    Phr ;
    S ;
    Qu ;
    Imp ;
    Verb ;
    TV ;
    Adj ;
    Noun ;
    CN ;
    NP ;
    Adv ;
    Prep ;

  fun
    PhrS : S -> Phr ;
    PhrQu : Qu -> Phr ;
    PhrImp : Imp -> Phr ;

    SVerb, SNegVerb : NP -> Verb -> S ;
    SVerbPP, SNegVerbPP : NP -> Verb -> Adv -> S ;
    STV, SNegTV : NP -> TV -> NP -> S ;
    SAdj, SNegAdj : NP -> Adj -> S ;
    SAdjPP, SNegAdjPP : NP -> Adj -> Adv -> S ;
    SCN, SNegCN : NP -> CN -> S ;
    SAdv,SNegAdv : NP -> Adv -> S ;

    QuVerb, QuNegVerb : NP -> Verb -> Qu ;

    ImpVerb, ImpNegVerb : Verb -> Imp ;
    ImpAdj, ImpNegAdj : Adj -> Imp ;
    ImpCN, ImpNegCN : CN -> Imp ;
    ImpAdv,ImpNegAdv : Adv -> Imp ;

    ModNoun : Adj -> Noun -> Noun ;
    PrepNP : Prep -> NP -> Adv ;
    PrepNoun : CN -> Prep -> NP -> CN ;
    CNNoun : Noun -> CN ;
    DefNP, IndefNP, EveryNP, AllNP : CN -> NP ;

    PossessPrep : Prep ;
}
