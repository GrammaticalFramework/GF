--!
--2 Rules
--
-- This set of rules is minimal, in the sense of defining the simplest combinations
-- of categories and not having redundant rules.
-- When the resource grammar is used as a library, it will often be useful to
-- access it through an intermediate library that defines more rules as 
-- 'macros' for combinations of the ones below.

abstract Rules = Categories ** {

--!
--3 Nouns and noun phrases
--

fun 
  UseN        : N -> CN ;                  -- "car"
  UsePN       : PN -> NP ;                 -- "John"

  SymbPN      : String -> PN ;             -- "x"
  SymbCN      : CN -> String -> CN ;       -- "number x"
  IntCN       : CN -> Int -> CN ;          -- "number 53"

  IndefOneNP  : CN -> NP ;                 -- "a car", "cars"
  IndefNumNP  : Num -> CN -> NP ;          -- "houses", "86 houses"
  DefOneNP    : CN -> NP ;                 -- "the car"
  DefNumNP    : Num -> CN -> NP ;          -- "the cars", "the 86 cars"

  DetNP       : Det -> CN -> NP ;          -- "every car"
  MassNP      : CN -> NP ;                 -- "wine"

  AppN2       : N2 -> NP -> CN ;           -- "successor of zero"
  AppN3       : N3 -> NP -> N2 ;           -- "flight from Paris"
  UseN2       : N2 -> CN ;                 -- "successor"

  ModAP       : AP -> CN -> CN ;           -- "red car"
  CNthatS     : CN -> S -> CN ;            -- "idea that the Earth is flat"

  ModGenOne   : NP -> CN -> NP ;           -- "John's car"
  ModGenNum   : Num -> NP -> CN -> NP ;    -- "John's cars", "John's 86 cars"

  UseInt      : Int -> Num ;               -- "32"  --- assumes i > 1
  NoNum       : Num ;                      -- no numeral modifier

--!
--3 Adjectives and adjectival phrases
--

  UseA        : A -> AP ;                  -- "red"
  ComplA2     : A2 -> NP -> AP ;           -- "divisible by two"

  PositADeg   : ADeg -> AP ;               -- "old"
  ComparADeg  : ADeg -> NP -> AP ;         -- "older than John"
  SuperlNP    : ADeg -> CN -> NP ;         -- "the oldest man"



--!
--3 Verbs and verb phrases
--
-- The main uses of verbs and verb phrases have been moved to the
-- module $Verbphrase$ (deep $VP$ nesting) and its alternative,
-- $Clause$ (shallow many-place predication structure).

  PredAS       : AS -> S  -> Cl ;         -- "it is good that he comes"                
  PredV0       : V0 -> Cl ;               -- "it is raining"

-- Partial saturation.

  UseV2        : V2 -> V ;                    -- "loves"
  ComplV3      : V3 -> NP -> V2 ;             -- "prefers wine (to beer)"

  ComplA2S     : A2S -> NP  -> AS ;           -- "good for John"

  TransVV2     : VV -> V2 -> V2 ;             -- (which song do you) want to play

  UseV2V : V2V -> VV ;
  UseV2S : V2S -> VS ;
  UseV2Q : V2Q -> VQ ;
  UseA2S : A2S -> AS ;
  UseA2V : A2V -> AV ;

-- Formation of infinitival phrases.

  AdjPart : V -> A ;                     -- forgotten

  UseCl  : TP -> Cl  -> S ;
  UseRCl : TP -> RCl -> RS ;
  UseQCl : TP -> QCl -> QS ;

  PosTP  : Tense -> Ant -> TP ;
  NegTP  : Tense -> Ant -> TP ;

  TPresent : Tense ;
  TPast    : Tense ;
  TFuture  : Tense ;
  TConditional : Tense ;

  ASimul   : Ant ;
  AAnter   : Ant ;

--!
--3 Adverbs
--
-- Here is how complex adverbs can be formed and used.

  AdjAdv : AP -> Adv ;                 -- "freely", "more consciously than you"
  AdvPP  : PP -> Adv ;                 -- "in London", "after the war"
  PrepNP : Prep -> NP -> PP ;          -- "in London", "after the war"

  AdvCN  : CN -> PP -> CN ;            -- "house in London"
  AdvAP  : AdA -> AP -> AP ;           -- "very good"

--!
--3 Sentences and relative clauses
--

  SlashV2  : NP -> V2 -> Slash ;                -- "John doesn't love"

  IdRP     : RP ;                               -- "which"
  FunRP    : N2 -> RP -> RP ;                   -- "the successor of which"
  RelSlash : RP -> Slash -> RCl ;               -- "that I wait for"/"for which I wait" 
  ModRS    : CN -> RS -> CN ;                   -- "man who walks"
  RelCl    : Cl -> RCl ;                        -- "such that it is even"

--!
--3 Questions and imperatives
--

  WhoOne, WhoMany : IP ;                    -- "who (is)", "who (are)"
  WhatOne, WhatMany : IP ;                  -- "what (is)", "what (are)"
  FunIP : N2 -> IP -> IP ;                  -- "the mother of whom"
  NounIPOne, NounIPMany : CN -> IP ;        -- "which car", "which cars"

  QuestCl    : Cl -> QCl ;                  -- "does John walk"; "doesn't John walk"
  IntSlash   : IP -> Slash -> QCl ;         -- "whom does John see"
  QuestAdv   : IAdv -> Cl -> QCl ;          -- "why do you walk"

  PosImpVP, NegImpVP : VPI -> Imp ;         -- "(don't) be a man"

----rename these ??
  IndicPhrase : S -> Phr ;                  -- "I walk."
  QuestPhrase : QS -> Phr ;                 -- "Do I walk?"
  ImperOne, ImperMany : Imp -> Phr ;        -- "Be a man!", "Be men!"

  AdvCl  : Cl -> Adv -> Cl ;                -- "John walks in the park"
  AdvPhr : AdC -> S -> Phr ;                -- "Therefore, 2 is prime."

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
  SubjQS    : Subj -> S -> QS -> QS ;      -- "if you are new, who are you?"

--!
--2 One-word utterances
--
-- These are, more generally, *one-phrase utterances*. The list below
-- is very incomplete.

  PhrNP   : NP -> Phr ;                    -- "Some man.", "John."
  PhrOneCN, PhrManyCN : CN -> Phr ;        -- "A car.", "Cars."
  PhrIP   : IAdv -> Phr ;                  -- "Who?"
  PhrIAdv : IAdv -> Phr ;                  -- "Why?"
  PhrVPI  : VPI -> Phr ;                   -- "Tända ljus."

--!
--2 Text formation
--
-- A text is a sequence of phrases. It is defined like a non-empty list.
  
  OnePhr  : Phr -> Text ;
  ConsPhr : Phr -> Text -> Text ;

--2 Special constructs.
--
-- These constructs tend to have language-specific syntactic realizations.

  ExistCN    : CN -> Cl ;                       -- "there is a bar"
  ExistNumCN : Num -> CN -> Cl ;                -- "there are (86) bars"

--- The type signatures of these ones should be changed from VP to VPI.

  OneVP        : VP -> Cl ;                     -- "one walks"

} ;
