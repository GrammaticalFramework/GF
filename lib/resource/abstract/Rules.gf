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

  PredV       : V  -> VP ;             -- "walk", "doesn't walk"
  PredPassV   : V  -> VP ;             -- "is seen", "is not seen"
  PredV2      : V2 -> NP -> VP ;       -- "sees John", "doesn't see John"
---  PredV3      : V3 -> NP -> NP -> VG ;       -- "prefers wine to beer"
  PredV3      : V3 -> NP -> V2 ;       -- "prefers wine (to beer)"
  PredVS      : VS -> S  -> VP ;       -- "says that I run", "doesn't say..."
  PredVV      : VV -> VPI -> VP ;      -- "can run", "can't run", "tries to run"

  PredNP      : NP -> VP ;             -- "is John", "is not John"
  PredPP      : PP -> VP ;             -- "is in France", "is not in France"
  PredAP      : AP -> VP ;             -- "is old", "isn't old"
  PredSuperl  : ADeg -> VP ;           -- "is the oldest"
  PredCN      : CN -> VP ;             -- "is a man", "isn't a man"
  VTrans      : V2 -> V ;              -- "loves"

---  PosVG,NegVG : VG -> VP ;             -- 

  PredVP      : NP -> VP -> Cl ;       -- preserves all pol/tense variation

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

---  PredVP   : NP -> VP -> S ;                   -- "John walks"
---  PosSlashV2,NegSlashV2 : NP -> V2 -> Slash ;  -- "John sees", "John doesn't see"
  SlashV2  : NP -> V2 -> Slash ;  -- "John sees", "John doesn't see"
---  OneVP    : VP -> S ;                         -- "one walks"
  OneVP    : VP -> Cl ;                        -- "one walks"
---  ThereNP  : NP -> S ;                         -- "there is a bar","there are 86 bars"
  ExistCN  : CN -> Cl ;                        -- "there is a bar"
  ExistNumCN : Num -> CN -> Cl ;               -- "there are (86) bars"

  IdRP     : RP ;                              -- "which"
  FunRP    : N2 -> RP -> RP ;                  -- "the successor of which"
  RelVP    : RP -> VP -> RCl ;                  -- "who walks", "who doesn't walk"
  RelSlash : RP -> Slash -> RCl ;               -- "that I wait for"/"for which I wait" 
---  ModRC    : CN -> RS -> CN ;                   -- "man who walks"
  ModRS    : CN -> RS -> CN ;                   -- "man who walks"
---  RelSuch  : S -> RCl ;                        -- "such that it is even"
  RelCl    : Cl -> RCl ;                        -- "such that it is even"

--!
--3 Questions and imperatives
--

  WhoOne, WhoMany : IP ;                   -- "who (is)", "who (are)"
  WhatOne, WhatMany : IP ;                 -- "what (is)", "what (are)"
  FunIP : N2 -> IP -> IP ;                 -- "the mother of whom"
  NounIPOne, NounIPMany : CN -> IP ;       -- "which car", "which cars"
 ---- NounIPHowMany : CN -> IP ;               -- "how many cars"

  QuestVP   : NP -> VP -> QCl ;             -- "does John walk"; "doesn't John walk"
  IntVP     : IP -> VP -> QCl ;             -- "who walks"
  IntSlash  : IP -> Slash -> QCl ;          -- "whom does John see"
---  QuestAdv  : IAdv -> NP -> VP -> QS ;     -- "why do you walk"
  QuestAdv  : IAdv -> NP -> VP -> QCl ;     -- "why do you walk"
---  IsThereNP : NP -> QS ;                    -- "is there a bar", "are there (86) bars"
  ExistQCl  : CN -> QCl ;                   -- "is there a bar", 
  ExistNumQCl : Num -> CN -> QCl ;          -- "are there (86) bars"

---  ImperVP : VP -> Imp ;                  -- "be a man"
  PosImperVP, NegImperVP : VP -> Imp ;      -- "(don't) be a man"

----rename these ??
  IndicPhrase : S -> Phr ;                 -- "I walk."
  QuestPhrase : QS -> Phr ;                -- "Do I walk?"
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
---  SubjQu    : Subj -> S -> QS -> QS ;      -- "if you are new, who are you?"
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

--- next

    PredVV2 : VV -> V2 -> V2 ;      -- (which song do you) want to play
    AdjPart : V -> A ;              -- forgotten
    ReflV2  : V2 -> VP ;

-- In these predications, the last argument gets its agreement
-- features from the second, and cannot hence be made to produce
-- $V2A$/$V2S$.

    PredV2A     : V2A -> NP -> AP -> VP ;
    PredSubjV2V : V2V -> NP -> VPI -> VP ;

--- In these three it would be possible, but hardly useful...

    PredObjV2V  : V2V  -> NP -> VPI -> VP ;
    PredV2S     : V2S  -> NP -> S   -> VP ;
    PredV2Q     : V2Q  -> NP -> QS  -> VP ;

    PredAS  : AS  -> S   -> Cl ;
    PredA2S : A2S -> NP  -> AS ;
    PredAV  : AV  -> VPI -> VP ;
    PredSubjA2V : A2V  -> NP -> VPI -> VP ;
    PredObjA2V  : A2V  -> NP -> VPI -> VP ;
    PredV0  : V0 -> Cl ;

    PredVQ  : VQ -> QS -> VP ;
    PredVA  : VA -> AP -> VP ;

    UseV2V : V2V -> VV ;
    UseV2S : V2S -> VS ;
    UseV2Q : V2Q -> VQ ;
    UseA2S : A2S -> AS ;
    UseA2V : A2V -> AV ;

    UseCl  : TP -> Cl  -> S ;
    UseRCl : TP -> RCl -> RS ;
    UseQCl : TP -> QCl -> QS ;
    PosVP, NegVP : Ant -> VP  -> VPI ;

    ProgVP : VPI -> VP ;  -- he is eating

    PosTP  : Tense -> Ant -> TP ;
    NegTP  : Tense -> Ant -> TP ;

    TPresent : Tense ;
    TPast    : Tense ;
    TFuture  : Tense ;
    TConditional : Tense ;

    ASimul   : Ant ;
    AAnter   : Ant ;

} ;

