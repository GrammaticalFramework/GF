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
-- The principal way of forming sentences ($S$) is by combining a noun phrase
-- with a verb phrase (the $PredVP$ rule below). In addition to this, verb
-- phrases have uses in relative clauses and questions. Verb phrases already
-- have (or have not) a negation, but they are formed from verbal groups
-- ($VG$), which have both positive and negative forms.

  UseV         : V  -> VP ;               -- "walks"
  UsePassV     : V  -> VP ;               -- "is seen"
  ComplV2      : V2 -> NP -> VP ;         -- "sees Mary"
  ComplReflV2  : V2 -> VP ;               -- "loves himself"
  ComplVS      : VS -> S -> VP ;          -- "says that Mary runs"
  ComplVV      : VV -> VPI -> VP ;        -- "must walk"
  ComplVQ      : VQ -> QS -> VP ;         -- "asks who will come"
  ComplVA      : VA -> AP -> VP ;         -- "looks ill"
  ComplV2A     : V2A -> NP -> AP -> VP ;  -- "paints the house red"
  ComplSubjV2V : V2V -> NP -> VPI -> VP ; -- "promises Mary to leave"
  ComplObjV2V  : V2V -> NP -> VPI -> VP ; -- "asked him to go"
  ComplV2S     : V2S -> NP -> S   -> VP ; -- "told me that you came" 
  ComplV2Q     : V2Q -> NP -> QS  -> VP ; -- "asks me if you come"

  PredAP       : AP -> VP ;               -- "is old"
  PredSuperl   : ADeg -> VP ;             -- "is the oldest"
  PredCN       : CN -> VP ;               -- "is a man"
  PredNP       : NP -> VP ;               -- "is Bill"
  PredPP       : PP -> VP ;               -- "is in France"
  PredAV       : AV  -> VPI -> VP   ;     -- "is eager to leave"
  PredObjA2V   : A2V -> NP -> VPI -> VP ; -- "is easy for us to convince"

  PredAS       : AS -> S  -> Cl ;         -- "it is good that he comes"                
  PredV0       : V0 -> Cl ;               -- "it is raining"

-- These rules *use* verb phrases: 
-- $PredVP$, $IntVP$, $RelVP$, $QuestVP$, $QuestAdv$.

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

  PosVP, NegVP : Ant -> VP  -> VPI ;

  ProgVG : VP  -> VP ;  -- he is eating

  AdjPart      : V -> A ;                     -- forgotten

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

  AdvVP  : VP -> Adv -> VP ;           -- "always walks", "walks in the park" 
  AdvCN  : CN -> PP -> CN ;            -- "house in London"
  AdvAP  : AdA -> AP -> AP ;           -- "very good"

--!
--3 Sentences and relative clauses
--

  PredVP   : NP -> VP -> Cl ;                   -- "John walks"
  
  SlashV2  : NP -> V2 -> Slash ;                -- "John doesn't love"

  IdRP     : RP ;                               -- "which"
  FunRP    : N2 -> RP -> RP ;                   -- "the successor of which"
  RelVP    : RP -> VP -> RCl ;                  -- "who walks", "who doesn't walk"
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

  QuestVP   : NP -> VP -> QCl ;             -- "does John walk"; "doesn't John walk"
  IntVP     : IP -> VP -> QCl ;             -- "who walks"
  IntSlash  : IP -> Slash -> QCl ;          -- "whom does John see"
  QuestAdv  : IAdv -> NP -> VP -> QCl ;     -- "why do you walk"

  PosImperVP, NegImperVP : VP -> Imp ;      -- "(don't) be a man"

----rename these ??
  IndicPhrase : S -> Phr ;                  -- "I walk."
  QuestPhrase : QS -> Phr ;                 -- "Do I walk?"
  ImperOne, ImperMany : Imp -> Phr ;        -- "Be a man!", "Be men!"

  PrepS : PP -> AdS ;                       -- "in Sweden, (there are bears)"
  AdvS  : AdS -> S -> Phr ;                 -- "Therefore, 2 is prime."

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

--2 Special constructs.
--
-- These constructs tend to have language-specific syntactic realizations.

  OneVP      : VP -> Cl ;                       -- "one walks"

  ExistCN    : CN -> Cl ;                       -- "there is a bar"
  ExistNumCN : Num -> CN -> Cl ;                -- "there are (86) bars"

  ExistQCl  : CN -> QCl ;                   -- "is there a bar", 
  ExistNumQCl : Num -> CN -> QCl ;          -- "are there (86) bars"

} ;

