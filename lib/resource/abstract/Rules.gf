--!
--2 Rules
--
-- This set of rules is minimal, in the sense of defining the simplest combinations
-- of categories and not having redundant rules.
-- When the resource grammar is used as a library, it will often be useful to
-- access it through an intermediate library that defines more rules as 
-- 'macros' for combinations of the ones below.

abstract Rules = Categories, Numerals ** {

--!
--3 Nouns and noun phrases
--

fun 
  UseN        : N -> CN ;                  -- "car"
  UsePN       : PN -> NP ;                 -- "John"

  SymbPN      : String -> PN ;             -- "x"
  SymbCN      : CN -> String -> CN ;       -- "number x"

  IndefOneNP  : CN -> NP ;                 -- "a car", "cars"
  IndefNumNP  : Num -> CN -> NP ;          -- "houses", "86 houses"
  DefOneNP    : CN -> NP ;                 -- "the car"
  DefNumNP    : Num -> CN -> NP ;          -- "the cars", "the 86 cars"

  DetNP       : Det -> CN -> NP ;          -- "every car"
  MassNP      : CN -> NP ;                 -- "wine"

  AppN2       : N2 -> NP -> CN ;           -- "successor of zero"
  AppN3       : N3 -> NP -> N2 ;           -- "flight from Paris"
  UseN2       : N2 -> CN ;                 -- "successor"

  ModAdj      : AP -> CN -> CN ;           -- "red car"
  CNthatS     : CN -> S -> CN ;            -- "idea that the Earth is flat"

  ModGenOne   : NP -> CN -> NP ;           -- "John's car"
  ModGenNum   : Num -> NP -> CN -> NP ;    -- "John's cars", "John's 86 cars"

  UseInt      : Int -> Num ;               -- "32"  --- assumes i > 1
  UseNumeral  : Numeral -> Num ;           -- "thirty-two"  --- assumes i > 1
  NoNum       : Num ;                      -- no numeral modifier

--!
--3 Adjectives and adjectival phrases
--

  UseA1       : A1 -> AP ;                 -- "red"
  ComplA2     : A2 -> NP -> AP ;           -- "divisible by two"

  PositADeg   : ADeg -> AP ;               -- "old"
  ComparADeg  : ADeg -> NP -> AP ;         -- "older than John"
  SuperlADeg  : ADeg -> AP ;               -- "the oldest"

--!
--3 Verbs and verb phrases
--
-- The principal way of forming sentences ($S$) is by combining a noun phrase
-- with a verb phrase (the $PredVP$ rule below). In addition to this, verb
-- phrases have uses in relative clauses and questions. Verb phrases already
-- have (or have not) a negation, but they are formed from verbal groups
-- ($VG$), which have both positive and negative forms.

  PredV       : V  -> VG ;             -- "walk", "doesn't walk"
  PredPassV   : V  -> VG ;             -- "is seen", "is not seen"
  PredV2      : V2 -> NP -> VG ;       -- "sees John", "doesn't see John"
  PredV3      : V3 -> NP -> NP -> VG ; -- "prefers wine to beer"
  PredVS      : VS -> S  -> VG ;       -- "says that I run", "doesn't say..."
  PredVV      : VV -> VG -> VG ;       -- "can run", "can't run", "tries to run"

  PredNP      : NP -> VG ;             -- "is John", "is not John"
  PredAdv     : Adv -> VG ;            -- "is everywhere", "is not in France"
  PredAP      : AP -> VG ;             -- "is old", "isn't old"
  PredCN      : CN -> VG ;             -- "is a man", "isn't a man"
  VTrans      : V2 -> V ;              -- "loves"

  PosVG,NegVG : VG -> VP ;             -- 

  PredVG      : NP -> VG -> Cl ;       -- preserves all pol/tense variation

--!
--3 Adverbs
--
-- Here is how complex adverbs can be formed and used.

  AdjAdv : AP -> Adv ;                 -- "freely", "more consciously than you"
  AdvPP  : PP -> Adv ;                 -- "in London", "after the war"
  PrepNP : Prep -> NP -> PP ;          -- "in London", "after the war"

  AdvVP  : VP -> Adv -> VP ;           -- "always walks", "walks in the park" 
  AdvCN  : CN -> PP -> CN ;            -- "house in London"
  AdvAP  : AdA -> AP -> AP ;           -- "very good"

--!
--3 Sentences and relative clauses
--

  PredVP   : NP -> VP -> S ;                   -- "John walks"
  PosSlashV2,NegSlashV2 : NP -> V2 -> Slash ;  -- "John sees", "John doesn't see"
  OneVP    : VP -> S ;                         -- "one walks"
  ThereNP  : NP -> S ;                         -- "there is a bar","there are 86 bars"

  IdRP     : RP ;                              -- "which"
  FunRP    : N2 -> RP -> RP ;                  -- "the successor of which"
  RelVP    : RP -> VP -> RC ;                  -- "who walks", "who doesn't walk"
  RelSlash : RP -> Slash -> RC ;               -- "that I wait for"/"for which I wait" 
  ModRC    : CN -> RC -> CN ;                  -- "man who walks"
  RelSuch  : S -> RC ;                         -- "such that it is even"

--!
--3 Questions and imperatives
--

  WhoOne, WhoMany : IP ;                   -- "who (is)", "who (are)"
  WhatOne, WhatMany : IP ;                 -- "what (is)", "what (are)"
  FunIP : N2 -> IP -> IP ;                 -- "the mother of whom"
  NounIPOne, NounIPMany : CN -> IP ;       -- "which car", "which cars"

  QuestVP   : NP -> VP -> Qu ;             -- "does John walk"; "doesn't John walk"
  IntVP     : IP -> VP -> Qu ;             -- "who walks"
  IntSlash  : IP -> Slash -> Qu ;          -- "whom does John see"
  QuestAdv  : IAdv -> NP -> VP -> Qu ;     -- "why do you walk"
  IsThereNP : NP -> Qu ;                   -- "is there a bar", "are there (86) bars"

  ImperVP : VP -> Imp ;                    -- "be a man"

  IndicPhrase : S -> Phr ;                 -- "I walk."
  QuestPhrase : Qu -> Phr ;                -- "Do I walk?"
  ImperOne, ImperMany : Imp -> Phr ;       -- "Be a man!", "Be men!"

  PrepS : PP -> AdS ;                      -- "in Sweden, (there are bears)"
  AdvS  : AdS -> S -> Phr ;                -- "Therefore, 2 is prime."

--!
--3 Coordination
--
-- We consider "n"-ary coordination, with "n" > 1. To this end, we have introduced
-- a *list category* $ListX$ for each category $X$ whose expressions we want to
-- conjoin. Each list category has two constructors, the base case being $TwoX$.

-- We have not defined coordination of all possible categories here,
-- since it can be tricky in many languages. For instance, $VP$ coordination
-- is linguistically problematic in German because $VP$ is a discontinuous
-- category.

  ConjS  : Conj -> ListS -> S ;            -- "John walks and Mary runs"
  ConjAP : Conj -> ListAP -> AP ;          -- "even and prime"
  ConjNP : Conj -> ListNP -> NP ;          -- "John or Mary"

  ConjDS  : ConjD -> ListS -> S ;          -- "either John walks or Mary runs"
  ConjDAP : ConjD -> ListAP -> AP ;        -- "both even and prime"
  ConjDNP : ConjD -> ListNP -> NP ;        -- "either John or Mary"

  TwoS  : S -> S -> ListS ;
  ConsS : ListS -> S -> ListS ;

  TwoAP  : AP -> AP -> ListAP ;
  ConsAP : ListAP -> AP -> ListAP ;

  TwoNP  : NP -> NP -> ListNP ;
  ConsNP : ListNP -> NP -> ListNP ;

--!
--3 Subordination
--
-- Subjunctions are different from conjunctions, but form
-- a uniform category among themselves.

  SubjS     : Subj -> S -> S -> S ;        -- "if 2 is odd, 3 is even"
  SubjImper : Subj -> S -> Imp -> Imp ;    -- "if it is hot, use a glove!"
  SubjQu    : Subj -> S -> Qu -> Qu ;      -- "if you are new, who are you?"
  SubjVP    : VP -> Subj -> S -> VP ;      -- "(a man who) sings when he runs"

--!
--2 One-word utterances
--
-- These are, more generally, *one-phrase utterances*. The list below
-- is very incomplete.

  PhrNP   : NP -> Phr ;                    -- "Some man.", "John."
  PhrOneCN, PhrManyCN : CN -> Phr ;        -- "A car.", "Cars."
  PhrIP   : IAdv -> Phr ;                  -- "Who?"
  PhrIAdv : IAdv -> Phr ;                  -- "Why?"

--!
--2 Text formation
--
-- A text is a sequence of phrases. It is defined like a non-empty list.
  
  OnePhr  : Phr -> Text ;
  ConsPhr : Phr -> Text -> Text ;

} ;

