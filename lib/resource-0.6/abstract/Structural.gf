--1 GF Resource Grammar API for Structural Words
-- 
-- AR 21/11/2003
--
-- Here we have some words belonging to closed classes and appearing
-- in all languages we have considered.
-- Sometimes they are not really meaningful, e.g. $TheyNP$ in French
-- should really be replaced by masculine and feminine variants.

abstract Structural = Combinations ** {

fun

--!
--2 Determiners and noun phrases
--
-- Many plural determiners can take a numeral modifier. So can the plural
-- pronouns "we" and "you".

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

--!
--2 Auxiliary verbs
--
-- Depending on language, all, some, or none of there verbs belong to
-- a separate class of *auxiliary* verbs. The list is incomplete.

  CanVV, CanKnowVV, MustVV : VV ;             -- can (pouvoir/savoir), must
  WantVV : VV ;                               -- want (to do)

--!
--2 Adverbials
--

  WhenIAdv,WhereIAdv,WhyIAdv,HowIAdv : IAdv ; -- when, where, why, how
  EverywhereNP, SomewhereNP,NowhereNP : AdV ; -- everywhere, somewhere, nowhere  
  VeryAdv, TooAdv : AdA ;                     -- very, too
  AlmostAdv, QuiteAdv : AdA ;                 -- almost, quite
  OtherwiseAdv, ThereforeAdv : AdS ;          -- therefore, otherwise            

--!
--2 Conjunctions and subjunctions
--

  AndConj, OrConj : Conj ;                    -- and, or
  BothAnd, EitherOr, NeitherNor : ConjD ;     -- both-and, either-or, neither-nor
  IfSubj, WhenSubj, AlthoughSubj : Subj ;     -- if, when, although

--!
--2 Prepositions
--
-- We have carefully chosen a set of semantic relations expressible
-- by prepositions in some languages, by cases or postpositions in
-- others. Complement uses of prepositions are not included, and
-- should be treated by the use of many-place verbs, adjectives, and
-- functions.

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
