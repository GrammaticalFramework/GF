--!
--2 Rules
--
-- This set of rules is minimal, in the sense of defining the simplest combinations
-- of categories and not having redundant rules.
-- When the resource grammar is used as a library, it will often be useful to
-- access it through an intermediate library that defines more rules as 
-- 'macros' for combinations of the ones below.

abstract Shallow = {

--1 Abstract Syntax Categories for Multilingual Resource Grammar
--
-- Aarne Ranta 2002 -- 2004
--
-- Although concrete syntax differs a lot between different languages,
-- many structures can be treated as common, on the level
-- of abstraction that GF provides. 
-- What we will present in the following is a linguistically oriented abstract 
-- syntax that has been successfully defined for the following languages:
--
--* $Eng$lish
--* $Fin$nish
--* $Fre$nch
--* $Ger$man
--* $Ita$lian
--* $Rus$sian
--* $Swe$dish
--
-- The three-letter prefixes are used in file names all over the resource
-- grammar library; we refer to them commonly as $X$ below.
--!
-- The grammar has been applied to define language
-- fragments on technical or near-to-technical domains: database queries,
-- video recorder dialogue systems, software specifications, and a 
-- health-related phrase book. Each new application helped to identify some
-- missing structures in the resource and suggested some additions, but the
-- number of required additions was usually small.
-- 
-- To use the resource in applications, you need the following 
-- $cat$ and $fun$ rules in $oper$ form, completed by taking the
-- $lincat$ and $lin$ judgements of a particular language. This is done
-- by using, instead of this module, the $reuse$ module which has the name
-- $ResourceX$. It is located in the subdirectory
-- $lib/resource/lang$ where $lang$ is the full name of the language.


--!
--2 Categories
--
-- The categories of this resource grammar are mostly 'standard' categories
-- of linguistics. Their is no claim that they correspond to semantic categories
-- definable in type theory: to define such correspondences is the business
-- of applications grammars. In general, the correspondence between linguistic
-- and semantic categories is many-to-many.
--
-- Categories that may look special are $A2$, $N2$, and $V2$. They are all
-- instances of endowing another category with a complement, which can be either
-- a direct object (whose case may vary) or a prepositional phrase. Prepositional
-- phrases that are not complements belong to the category
-- $Adv$ of adverbs.
--
-- In each group below, some categories are *lexical* in the sense of only
-- containing atomic elements. These elements are not necessarily expressed by
-- one word in all languages; the essential thing is that they have no
-- constituents. Thus they have no productions in this part of the 
-- resource grammar. The $ParadigmsX$ grammars provide ways of defining
-- lexical elements.
--
-- Lexical categories are listed before other categories
-- in each group and divided by an empty line.

--!
--3 Nouns and noun phrases
--

cat
  N ;      -- simple common noun,    e.g. "car"
  CN ;     -- common noun phrase,    e.g. "red car", "car that John owns"
  N2 ;     -- function word,         e.g. "mother (of)"
  N3 ;     -- two-place function,    e.g. "flight (from) (to)"

  PN ;     -- proper name,           e.g. "John", "New York"
  NP ;     -- noun phrase,           e.g. "John", "all cars", "you"
  Det ;    -- determiner,            e.g. "every", "all"
  Num ;    -- numeral,               e.g. "three", "879"            

--!
--3 Adjectives and adjectival phrases
--

  A ;      -- one-place adjective,   e.g. "even"
  A2 ;     -- two-place adjective,   e.g. "divisible (by)"
  ADeg ;   -- degree adjective,      e.g. "big/bigger/biggest"

  AP ;     -- adjective phrase,      e.g. "divisible by two", "bigger than John"

-- The difference between $A$ and $ADeg$ is that the former has no
-- comparison forms. 

--!
--3 Verbs and verb phrases
--

  V ;      -- one-place verb,        e.g. "walk"
  V2 ;     -- two-place verb,        e.g. "love", "wait (for)", "switch on"
  V3 ;     -- three-place verb,      e.g. "give", "prefer (stg) (to stg)"
  VS ;     -- sentence-compl. verb,  e.g. "say", "prove"
  VV ;     -- verb-compl. verb,      e.g. "can", "want"

  VP ;     -- verb phrase,           e.g. "switch the light on"
  VPI ;    -- infinitive verb phrase e.g. "switch the light on", "not have run"

--!
--3 Adverbs and prepositions/cases
--

  Adv ;    -- sentence adverb        e.g. "now", "in the house"
  AdV ;    -- verb adverb            e.g. "always"
  AdA ;    -- ad-adjective           e.g. "very"
  AdC ;    -- conjoining adverb      e.g. "therefore", "otherwise"
  PP ;     -- prepositional phrase   e.g. "in London"
  Prep ;   -- pre/postposition, case e.g. "after", Adessive

--!
--3 Sentences and relative clauses
--
-- This group has no lexical categories.

  S ;      -- sentence (fixed tense)  e.g. "John walks", "John walked"
  Cl ;     -- clause (variable tense) e.g. "John walks"/"John walked"
  Slash ;  -- sentence without NP,    e.g. "John waits for (...)"
  RP ;     -- relative pronoun,       e.g. "which", "the mother of whom"
  RCl ;    -- relative clause,        e.g. "who walks", "that I wait for"

--!
--3 Questions and imperatives
--
-- This group has no lexical categories.

  IP ;     -- interrogative pronoun, e.g. "who", "whose mother", "which yellow car"
  IAdv ;   -- interrogative adverb., e.g. "when", "why" 
  QCl ;    -- question,              e.g. "who walks"
  Imp ;    -- imperative,            e.g. "walk!"

--!
--3 Coordination and subordination
--

  Conj ;   -- conjunction,           e.g. "and"
  ConjD ;  -- distributed conj.      e.g. "both - and"
  Subj ;   -- subjunction,           e.g. "if", "when"

  ListS ;  -- list of sentences
  ListAP ; -- list of adjectival phrases
  ListNP ; -- list of noun phrases

--!
--3 Complete utterances
--
-- This group has no lexical categories.

  Phr ;    -- full phrase,           e.g. "John walks.","Who walks?", "Wait for me!"
  Text ;   -- sequence of phrases    e.g. "One is odd. Therefore, two is even."

---- next

  V2A ;         -- paint the house red
  V2V ;         -- promise John to come / ask John to come
  V2S ;         -- tell John that it is raining
  VQ ;          -- ask who comes
  V2Q ;         -- ask John who comes
  VA ;          -- look yellow

  V0 ;          -- (it) rains

  AS ;          -- (it is) important that he comes
  A2S ;         -- (it is) important for me that he comes
  AV ;          -- difficult to play 
  A2V ;         -- difficult for him to play 

-- NB: it is difficult to play the sonata 
-- vs. it (the sonata) is difficult to play

--- also: John is easy (for you) to please vs. John is eager to please

  QS ;          -- question with fixed tense and polarity
  RS ;          -- relative clause with fixed tense and polarity

  TP ;          -- tense x polarity selector
  Tense ;       -- (abstract) tense
  Ant ;         -- (abstract) anteriority


--!
--3 Nouns and noun phrases
--

fun 
  UseN        : N -> CN ;                  -- "car"
  UsePN       : PN -> NP ;                 -- "John"

----  SymbPN      : String -> PN ;             -- "x"
----  SymbCN      : CN -> String -> CN ;       -- "number x"
----  IntCN       : CN -> Int -> CN ;          -- "number 53"

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

----  UseInt      : Int -> Num ;               -- "32"  --- assumes i > 1
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

  PredV       : NP -> V  -> Cl ;             -- "John walks"
  PredPassV   : NP -> V  -> Cl ;             -- "John is seen"
  PredV2      : NP -> V2 -> NP -> Cl ;       -- "John sees Mary"
  PredReflV2  : NP -> V2 -> Cl ;             -- "John loves himself"
  PredVS      : NP -> VS -> S  -> Cl ;       -- "John says that Mary runs"
  PredVV      : NP -> VV -> VPI -> Cl ;      -- "John must walk"
  PredVQ      : NP -> VQ -> QS -> Cl ;       -- "John asks who will come"
  PredVA      : NP -> VA -> AP -> Cl ;       -- "John looks ill"
  PredV2A     : NP -> V2A -> NP ->AP ->Cl ;  -- "John paints the house red"
  PredSubjV2V : NP -> V2V -> NP ->VPI ->Cl ; -- "John promises Mary to leave"

  PredAP      : NP -> AP -> Cl ;             -- "John is old"
  PredSuperl  : NP -> ADeg -> Cl ;           -- "John is the oldest"
  PredCN      : NP -> CN -> Cl ;             -- "John is a man"
  PredNP      : NP -> NP -> Cl ;             -- "John is Bill"
  PredPP      : NP -> PP -> Cl ;             -- "John is in France"
  PredAV      : NP -> AV  ->VPI ->Cl ;       -- "John is eager to leave"
  PredObjA2V  : NP -> A2V -> NP ->VPI ->Cl ; -- "John is easy for us to convince"

  PredObjV2V  : NP -> V2V  -> NP -> VPI -> Cl ;  -- "John asks me to come"
  PredV2S     : NP -> V2S  -> NP -> S   -> Cl ;  -- "John told me that it is good"
  PredV2Q     : NP -> V2Q  -> NP -> QS  -> Cl ;  -- "John asked me if it is good"

  PredAS      : AS -> S  -> Cl ;             -- "it is good that he comes"                
  PredV0      : V0 -> Cl ;                   -- "it is raining"

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

---  PosVP, NegVP : Ant -> VP  -> VPI ;

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

  AdvVP  : VP -> AdV -> VP ;           -- "always walks", "walks in the park" 
  AdvCN  : CN -> PP -> CN ;            -- "house in London"
  AdvAP  : AdA -> AP -> AP ;           -- "very good"

--!
--3 Sentences and relative clauses
--

  SlashV2    : NP -> V2 -> Slash ;              -- "John doesn't love"

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

  AdvCl  : Cl -> Adv -> Cl ;                -- "Therefore, 2 is prime."
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

