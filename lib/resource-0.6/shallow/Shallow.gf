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
--
-- S  ::= NP Adv* V NP? Adv*
--     |  NP Adv* "is" Adj Adv*
-- NP ::= Det CN
-- CN ::= Adj* N

abstract Shallow = {
  cat
    Phr ;
    S ;
    Qu ;
    Imp ;
    Verb ;
    TV ;
    Adj ;
    AdjDeg ; ----
    Adj2 ;   ----
    V3 ; ----
    N ;
    Noun ;
    CN ;
    PN ;
    NP ;
    Det ;
    Adv ;
    Prep ;
    Num ;

  fun
    PhrS   : S -> Phr ;
    PhrQu  : Qu -> Phr ;
    PhrImp : Imp -> Phr ;

    SVerb, SNegVerb     : NP -> Verb -> S ;
    SVerbPP, SNegVerbPP : NP -> Verb -> Adv -> S ;
    STV, SNegTV         : NP -> TV -> NP -> S ;
    SAdj, SNegAdj       : NP -> Adj -> S ;
    SAdjPP, SNegAdjPP   : NP -> Adj -> Adv -> S ;
    SCN, SNegCN         : NP -> CN -> S ;
    SAdv,SNegAdv        : NP -> Adv -> S ;

    QuVerb, QuNegVerb   : NP -> Verb -> Qu ;

    ImpVerb, ImpNegVerb : Verb -> Imp ;
    ImpAdj, ImpNegAdj   : Adj -> Imp ;
    ImpCN, ImpNegCN     : CN -> Imp ;
    ImpAdv,ImpNegAdv    : Adv -> Imp ;

    UsePN : PN -> NP ;
    DefNP : CN -> NP ;
    IndefNP : CN -> NP ;
    DetNP : Det -> CN -> NP ;

    PrepNP   : Prep -> NP -> Adv ;
    AdvNoun  : CN -> Adv -> CN ;

    CNNoun   : Noun -> CN ;
    NounN    : N -> Noun ;
    ModNoun  : Adj -> Noun -> Noun ;

    NoNum : Num ;

-- copied from Structural

  EveryDet, WhichDet, AllMassDet,             -- every, sg which, sg all
  SomeDet, AnyDet, NoDet,                     -- sg some, any, no
  MostDet, MostsDet, ManyDet, MuchDet : Det ; -- sg most, pl most, many, much
  ThisDet, ThatDet : Det ;                    -- this, that

  AllNumDet, WhichNumDet,                     -- pl all, which (86)
  SomeNumDet, AnyNumDet, NoNumDet,            -- pl some, any, no
  TheseNumDet, ThoseNumDet : Num -> Det ;     -- these, those (86)

  ThisNP, ThatNP : NP ;                       -- this, that
  TheseNumNP, ThoseNumNP : Num -> NP ;        -- these, those (86)
  INP, ThouNP, HeNP, SheNP, ItNP : NP ;       -- personal pronouns in singular
  WeNumNP, YeNumNP : Num -> NP ;              -- these pronouns can take numeral 
  TheyNP : NP ; YouNP : NP ;                  -- they, the polite you

  EverybodyNP, SomebodyNP, NobodyNP,          -- everybody, somebody, nobody
  EverythingNP, SomethingNP, NothingNP : NP ; -- everything, something, nothing


  InPrep, OnPrep, ToPrep, FromPrep,           -- spatial relations
  ThroughPrep, AbovePrep, UnderPrep,
  InFrontPrep, BehindPrep, BetweenPrep : Prep ;
  BeforePrep, DuringPrep, AfterPrep : Prep ;  -- temporal relations
  WithPrep, WithoutPrep, ByMeansPrep : Prep ; -- some other relations
  PossessPrep : Prep ;                        -- possessive/genitive
  PartPrep : Prep ;                           -- partitive "of" ("bottle of wine")
  AgentPrep : Prep ;                          -- agent "by" in passive constructions


--!
--2 Affirmation and negation
--
-- The negative-positive (French "si", German "doch") is missing.

  PhrYes, PhrNo : Phr ;                       -- yes, no


}
