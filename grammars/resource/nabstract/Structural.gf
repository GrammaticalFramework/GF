--2 Examples of structural words
-- 
-- Here we have some words belonging to closed classes and appearing
-- in all languages we have considered.
-- Sometimes they are not really meaningful, e.g. $TheyNP$ in French
-- should really be replaced by masculine and feminine variants.

abstract Structural = Combinations ** {

fun
  EveryDet, WhichDet, AllDet,                 -- every, sg which, sg all
  SomeDet, AnyDet, NoDet,                     -- sg some, any, no
  MostDet, MostsDet, ManyDet, MuchDet : Det ; -- sg most, pl most, many, much
  ThisDet, ThatDet : Det ;                    -- this, that

-- Many plural determiners can take a numeral modifier.

  AllsDet, WhichsDet,                         -- pl all, which (86)
  SomesDet, AnysDet, NosDet,                  -- pl some, any, no
  TheseDet, ThoseDet : Num -> Det ;           -- these, those (86)
  ThisNP, ThatNP : NP ;                       -- this, that
  TheseNP, ThoseNP : Num -> NP ;              -- these, those (86)
  INP, ThouNP, HeNP, SheNP, ItNP : NP ;       -- personal pronouns in singular
  WeNP, YeNP : Num -> NP ;                    -- these pronouns can take numeral 
  TheyNP : NP ;                               -- personal pronouns in plural
  YouNP : NP ;                                -- the polite you
  EverybodyNP, SomebodyNP, NobodyNP,          -- everybody, somebody, nobody
  EverythingNP, SomethingNP, NothingNP : NP ; -- everything, something, nothing
---  CanVV, CanKnowVV, MustVV : VV ;             -- can (pouvoir/savoir), must
---  WantVV : VV ;                               -- want (to do)
  WhenIAdv,WhereIAdv,WhyIAdv,HowIAdv : IAdv ; -- when, where, why, how
  EverywhereNP, SomewhereNP, NowhereNP : AdV ;-- everywhere, somewhere, nowhere  
  AndConj, OrConj : Conj ;                    -- and, or
  BothAnd, EitherOr, NeitherNor : ConjD ;     -- both-and, either-or, neither-nor
  IfSubj, WhenSubj, AlthoughSubj : Subj ;     -- if, when, although
  PhrYes, PhrNo : Phr ;                       -- yes, no
  VeryAdv, TooAdv : AdA ;                     -- very, too
  AlmostAdv, QuiteAdv : AdA ;                 -- almost, quite
  OtherwiseAdv, ThereforeAdv : AdS ;          -- therefore, otherwise            
  InPrep, OnPrep, ToPrep, FromPrep,           -- spatial relations
  ThroughPrep, AbovePrep, UnderPrep,
  InFrontPrep, BehindPrep, BetweenPrep : Prep ;
  BeforePrep, DuringPrep, AfterPrep : Prep ;  -- temporal relations
  WithPrep, WithoutPrep, ByMeansPrep : Prep ; -- some other relations
  PartPrep : Prep ;                           -- partitive "of" ("bottle of wine")
  AgentPrep : Prep ;                          -- agent "by" in passive constructions
}
