--1 Abstract Syntax for Multilingual Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
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
-- $grammars/resource/lang$ where $lang$ is the full name of the language.


abstract Combinations = PredefAbs ** {
--!
--2 Categories
--
-- The categories of this resource grammar are mostly 'standard' categories
-- of linguistics. Their is no claim that they correspond to semantic categories
-- definable in type theory: to define such correspondences is the business
-- of applications grammars. In general, the correspondence between linguistic
-- and semantic categories is many-to-many.
--
-- Categories that may look special are $Adj2$, $Fun$, and $TV$. They are all
-- instances of endowing another category with a complement, which can be either
-- a direct object (whose case may vary) or a prepositional phrase. Prepositional
-- phrases that are not complements belong to the category
-- $AdV$ of adverbials.
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
  PN ;     -- proper name,           e.g. "John", "New York"
  Fun ;    -- function word,         e.g. "mother (of)"
  Fun2 ;   -- two-place function,    e.g. "flight (from) (to)"

  CN ;     -- common noun phrase,    e.g. "red car", "car that John owns"
  NP ;     -- noun phrase,           e.g. "John", "all cars", "you"
  Det ;    -- determiner,            e.g. "every", "all"
  Num ;    -- numeral,               e.g. "three", "879"            

--!
--3 Adjectives and adjectival phrases
--

  Adj1 ;   -- one-place adjective,   e.g. "even"
  Adj2 ;   -- two-place adjective,   e.g. "divisible (by)"
  AdjDeg ; -- degree adjective,      e.g. "big/bigger/biggest"

  AP ;     -- adjective phrase,      e.g. "divisible by two", "bigger than John"

-- The difference between $Adj1$ and $AdjDeg$ is that the former has no
-- comparison forms. 

--!
--3 Verbs and verb phrases
--

  V ;      -- one-place verb,        e.g. "walk"
  TV ;     -- two-place verb,        e.g. "love", "wait (for)", "switch on"
  V3 ;     -- three-place verb,      e.g. "give", "prefer (stg) (to stg)"
  VS ;     -- sentence-compl. verb,  e.g. "say", "prove"
  VV ;     -- verb-compl. verb,      e.g. "can", "want"

  VG ;     -- verbal group,          e.g. "switch the light on"
  VP ;     -- verb phrase,           e.g. "switch the light on", "don't run"

--!
--3 Adverbials
--
-- This group has no lexical categories.

  AdV ;    -- adverbial              e.g. "now", "in the house"
  AdA ;    -- ad-adjective           e.g. "very"
  AdS ;    -- sentence adverbial     e.g. "therefore", "otherwise"
  Prep ;   -- pre/postposition, case e.g. "after", Adessive

--!
--3 Sentences and relative clauses
--
-- This group has no lexical categories.

  S ;      -- sentence,              e.g. "John walks"
  Slash ;  -- sentence without NP,   e.g. "John waits for (...)"
  RP ;     -- relative pronoun,      e.g. "which", "the mother of whom"
  RC ;     -- relative clause,       e.g. "who walks", "that I wait for"

--!
--3 Questions and imperatives
--
-- This group has no lexical categories.

  IP ;     -- interrogative pronoun, e.g. "who", "whose mother", "which yellow car"
  IAdv ;   -- interrogative adverb., e.g. "when", "why" 
  Qu ;     -- question,              e.g. "who walks"
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

--!
--2 Rules
--
-- This set of rules is minimal, in the sense of defining the simplest combinations
-- of categories and not having redundant rules.
-- When the resource grammar is used as a library, it will often be useful to
-- access it through an intermediate library that defines more rules as 
-- 'macros' for combinations of the ones below.

--!
--3 Nouns and noun phrases
--

fun 
  UseN        : N -> CN ;                  -- "car"
  UsePN       : PN -> NP ;                 -- "John"
  UseFun      : Fun -> CN ;                -- "successor"
  UseInt      : Int -> Num ;               -- "32"  --- assumes i > 1

  SymbPN      : String -> PN ;             -- "x"
  SymbCN      : CN -> String -> CN ;       -- "number x"

  ModAdj      : AP -> CN -> CN ;           -- "red car"
  DetNP       : Det -> CN -> NP ;          -- "every car"
  MassNP      : CN -> NP ;                 -- "wine"
  IndefOneNP  : CN -> NP ;                 -- "a car", "cars"
  IndefNumNP  : Num -> CN -> NP ;          -- "houses", "86 houses"
  DefOneNP    : CN -> NP ;                 -- "the car"
  DefNumNP    : Num -> CN -> NP ;          -- "the cars", "the 86 cars"
  ModGenOne   : NP -> CN -> NP ;           -- "John's car"
  ModGenNum   : Num -> NP -> CN -> NP ;    -- "John's cars", "John's 86 cars"
  AppFun      : Fun -> NP -> CN ;          -- "successor of zero"
  AppFun2     : Fun2 -> NP -> Fun ;        -- "flight from Paris"
  CNthatS     : CN -> S -> CN ;            -- "idea that the Earth is flat"
  NoNum       : Num ;                      -- no numeral modifier

--!
--3 Adjectives and adjectival phrases
--

  AdjP1       : Adj1 -> AP ;               -- "red"
  PositAdjP   : AdjDeg -> AP ;             -- "old"

  ComplAdj    : Adj2 -> NP -> AP ;         -- "divisible by two"
  ComparAdjP  : AdjDeg -> NP -> AP ;       -- "older than John"
  SuperlNP    : AdjDeg -> CN -> NP ;       -- "the oldest man"

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
  PredTV      : TV -> NP -> VG ;       -- "sees John", "doesn't see John"
  PredVS      : VS -> S  -> VG ;       -- "says that I run", "doesn't say..."
  PredVV      : VV -> VG -> VG ;       -- "can run", "can't run", "tries to run"
  PredV3      : V3 -> NP -> NP -> VG ; -- "prefers wine to beer"

  PredNP      : NP -> VG ;             -- "is John", "is not John"
  PredAdV     : AdV -> VG ;            -- "is everywhere", "is not in France"
  PredAP      : AP -> VG ;             -- "is old", "isn't old"
  PredCN      : CN -> VG ;             -- "is a man", "isn't a man"
  VTrans      : TV -> V ;              -- "loves"

  PosVG,NegVG : VG -> VP ;             -- 


--!
--3 Adverbs
--
-- Here is how complex adverbs can be formed and used.

  AdjAdv : AP -> AdV ;                 -- "freely", "more consciously than you"
  PrepNP : Prep -> NP -> AdV ;         -- "in London", "after the war"

  AdvVP  : VP -> AdV -> VP ;           -- "always walks", "walks in the park" 
  AdvCN  : CN -> AdV -> CN ;           -- "house in London", "house today"
  AdvAP  : AdA -> AP -> AP ;           -- "very good"

--!
--3 Sentences and relative clauses
--

  PredVP : NP -> VP -> S ;                     -- "John walks"
  PosSlashTV,NegSlashTV : NP -> TV -> Slash ;  -- "John sees", "John doesn't see"
  OneVP : VP -> S ;                            -- "one walks"
  ThereNP : NP -> S ;                          -- "there is a bar","there are 86 bars"

  IdRP : RP ;                              -- "which"
  FunRP : Fun -> RP -> RP ;                -- "the successor of which"
  RelVP : RP -> VP -> RC ;                 -- "who walks", "who doesn't walk"
  RelSlash : RP -> Slash -> RC ;           -- "that I wait for"/"for which I wait" 
  ModRC : CN -> RC -> CN ;                 -- "man who walks"
  RelSuch : S -> RC ;                      -- "such that it is even"

--!
--3 Questions and imperatives
--

  WhoOne, WhoMany : IP ;                   -- "who (is)", "who (are)"
  WhatOne, WhatMany : IP ;                 -- "what (is)", "what (are)"
  FunIP : Fun -> IP -> IP ;                -- "the mother of whom"
  NounIPOne, NounIPMany : CN -> IP ;       -- "which car", "which cars"

  QuestVP : NP -> VP -> Qu ;               -- "does John walk"; "doesn't John walk"
  IntVP : IP -> VP -> Qu ;                 -- "who walks"
  IntSlash : IP -> Slash -> Qu ;           -- "whom does John see"
  QuestAdv : IAdv -> NP -> VP -> Qu ;      -- "why do you walk"
  IsThereNP : NP -> Qu ;                   -- "is there a bar", "are there (86) bars"

  ImperVP : VP -> Imp ;                    -- "be a man"

  IndicPhrase : S -> Phr ;                 -- "I walk."
  QuestPhrase : Qu -> Phr ;                -- "Do I walk?"
  ImperOne, ImperMany : Imp -> Phr ;       -- "Be a man!", "Be men!"

  AdvS : AdS -> S -> Phr ;                 -- "Therefore, 2 is prime."

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

