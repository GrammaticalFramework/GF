--2 Examples of structural words
-- 
-- Here we have some words belonging to closed classes and appearing
-- in all languages we have considered.
-- Sometimes they are not really meaningful, e.g. $TheyNP$ in French
-- should really be replaced by masculine and feminine variants.

abstract Structural = Combinations ** {

fun
  EveryDet, AllDet, WhichDet, MostDet : Det ; -- every, all, which, most
  SomeDet, SomesDet, AnyDet, AnysDet, NoDet,  -- sg/pl some, any, no
  NosDet, ManyDet, MuchDet : Det ;            -- many, much
  ThisDet, TheseDet, ThatDet, ThoseDet : Det ;-- (this, these, that, those) car(s)
  ThisNP, TheseNP, ThatNP, ThoseNP : NP ;     -- this, these, that, those
  INP, ThouNP, HeNP, SheNP, ItNP : NP ;       -- personal pronouns in singular
  WeNP, YeNP, TheyNP : NP ;                   -- personal pronouns in plural
  YouNP : NP ;                                -- the polite you
  EverybodyNP, SomebodyNP, NobodyNP,          -- everybody, somebody, nobody
  EverythingNP, SomethingNP, NothingNP : NP ; -- everything, something, nothing
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
  AgentPrep : Prep ;                          -- agent "by" in passive constructions
}
