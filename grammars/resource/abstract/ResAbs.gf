--1 Abstract Syntax for Multilingual Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
--
-- Although concrete syntax differs a lot between different languages,
-- many structures can be found that are common, on a certain level
-- of abstraction. What we will present in the following is an abstract 
-- syntax that has been successfully defined for English, French, German, 
-- Italian, Russian, and Swedish. It has been applied to define language
-- fragments on technical or near-to-technical domains: database queries,
-- video recorder dialogue systems, software specifications, and a 
-- health-related phrase book.
--
-- To use the resource in applications, you need the following 
-- $cat$ and $fun$ rules in $oper$ form, completed by taking the
-- $lincat$ and $lin$ judgements of a particular language. There is 
-- a GF command for making this translation automatically.

--2 Categories
--
-- The categories of this resource grammar are mostly 'standard' categories
-- of linguistics. Their is no claim that they correspond to semantic categories
-- definable in type theory: to define such correspondences it the business
-- of applications grammars.
--
-- Categories that may look special are $Adj2$, $Fun$, and $TV$. They are all
-- instances of endowing another category with a complement, which can be either
-- a direct object (whose case may vary) or a prepositional phrase. This, together
-- with the category $Adv$, removes the need of a category of 
-- 'prepositional phrases', which is too language-dependent to make sense
-- on this level of abstraction.
--

abstract ResAbs = {

--3 Nouns and noun phrases
--

cat
  N ;      -- simple common noun,    e.g. "car"
  CN ;     -- common noun phrase,    e.g. "red car", "car that John owns"
  NP ;     -- noun phrase,           e.g. "John", "all cars", "you"
  PN ;     -- proper name,           e.g. "John", "New York"
  Det ;    -- determiner,            e.g. "every", "all"
  Fun ;    -- function word,         e.g. "mother (of)"
  Fun2 ;   -- two-place function,    e.g. "flight (from) (to)"

--3 Adjectives and adjectival phrases
--

  Adj1 ;   -- one-place adjective,   e.g. "even"
  Adj2 ;   -- two-place adjective,   e.g. "divisible (by)"
  AdjDeg ; -- degree adjective,      e.g. "big/bigger/biggest"
  AP ;     -- adjective phrase,      e.g. "divisible by two", "bigger than John"

--3 Verbs and verb phrases
--

  V ;      -- one-place verb,        e.g. "walk"
  TV ;     -- two-place verb,        e.g. "love", "wait (for)", "switch on"
  VS ;     -- sentence-compl. verb   e.g. "say", "prove"
  VP ;     -- verb phrase,           e.g. "switch the light on"

--3 Adverbials
--

  AdV ;    -- adverbial              e.g. "now", "in the house"
  AdA ;    -- ad-adjective           e.g. "very"
  AdS ;    -- sentence adverbial     e.g. "therefore", "otherwise"

--3 Sentences and relative clauses
--

  S ;      -- sentence,              e.g. "John walks"
  Slash ;  -- sentence without NP,   e.g. "John waits for (...)"
  RP ;     -- relative pronoun,      e.g. "which", "the mother of whom"
  RC ;     -- relative clause,       e.g. "who walks", "that I wait for"

--3 Questions and imperatives
--

  IP ;     -- interrogative pronoun, e.g. "who", "whose mother", "which yellow car"
  IAdv ;   -- interrogative adverb., e.g. "when", "why" 
  Qu ;     -- question,              e.g. "who walks"
  Imp ;    -- imperative,            e.g. "walk!"

--3 Coordination and subordination
--

  Conj ;   -- conjunction,           e.g. "and"
  ConjD ;  -- distributed conj.      e.g. "both - and"
  Subj ;   -- subjunction,           e.g. "if", "when"

  ListS ;  -- list of sentences
  ListAP ; -- list of adjectival phrases
  ListNP ; -- list of noun phrases

--3 Complete utterances
--

  Phr ;    -- full phrase,           e.g. "John walks.","Who walks?", "Wait for me!"
  Text ;   -- sequence of phrases    e.g. "One is odd. Therefore, two is even."

--2 Rules
--
-- This set of rules is minimal, in the sense defining the simplest combinations
-- of categories and of not having redundant rules.
-- When the resource grammar is used as a library, it will often be useful to
-- access it through an intermediate library that defines more rules as 
-- combinations of the ones below.

--3 Nouns and noun phrases
--

fun 
  UseN : N -> CN ;                         -- "car"
  ModAdj : AP -> CN -> CN ;                -- "red car"
  DetNP : Det -> CN -> NP ;                -- "every car"
  IndefOneNP, IndefManyNP : CN -> NP ;     -- "a car", "cars"
  DefOneNP, DefManyNP : CN -> NP ;         -- "the car", "the cars"
  ModGenOne, ModGenMany : NP -> CN -> NP ; -- "John's car", "John's cars"
  UsePN : PN -> NP ;                       -- "John"
  UseFun : Fun -> CN ;                     -- "successor"
  AppFun : Fun -> NP -> CN ;               -- "successor of zero"
  AppFun2 : Fun2 -> NP -> Fun ;            -- "flight from Paris"
  CNthatS : CN -> S -> CN ;                -- "idea that the Earth is flat"

--3 Adjectives and adjectival phrases
--

  AdjP1 : Adj1 -> AP ;                     -- "red"
  ComplAdj : Adj2 -> NP -> AP ;            -- "divisible by two"
  PositAdjP : AdjDeg -> AP ;               -- "old"
  ComparAdjP : AdjDeg -> NP -> AP ;        -- "older than John"
  SuperlNP : AdjDeg -> CN -> NP ;          -- "the oldest man"

--3 Verbs and verb phrases
--

  PosV, NegV : V -> VP ;                   -- "walk", "doesn't walk"
  PosA, NegA : AP -> VP ;                  -- "is old", "isn't old"
  PosCN, NegCN : CN -> VP ;                -- "is a man", "isn't a man"
  PosTV, NegTV : TV -> NP -> VP ;          -- "sees John", "doesn't see John"
  PosPassV, NegPassV : V -> VP ;           -- "is seen", "is not seen"
  PosNP, NegNP : NP -> VP ;                -- "is John", "is not John"
  PosVS, NegVS : VS -> S -> VP ;           -- "says that I run", "doesn't say..."

--3 Adverbials
--

  AdvVP : VP -> AdV -> VP ;                -- "always walks", "walks in the park" 
  LocNP : NP -> AdV ;                      -- "in London"
  AdvCN : CN -> AdV -> CN ;                -- "house in London", "house today"

  AdvAP : AdA -> AP -> AP ;                -- "very good"


--3 Sentences and relative clauses
--

  PredVP : NP -> VP -> S ;                     -- "John walks"
  PosSlashTV, NegSlashTV : NP -> TV -> Slash ; -- "John sees", "John doesn's see"
  OneVP : VP -> S ;                            -- "one walks"

  IdRP : RP ;                              -- "which"
  FunRP : Fun -> RP -> RP ;                -- "the successor of which"
  RelVP : RP -> VP -> RC ;                 -- "who walks"
  RelSlash : RP -> Slash -> RC ;           -- "that I wait for"/"for which I wait" 
  ModRC : CN -> RC -> CN ;                 -- "man who walks"
  RelSuch : S -> RC ;                      -- "such that it is even"

--3 Questions and imperatives
--

  WhoOne, WhoMany : IP ;                   -- "who (is)", "who (are)"
  WhatOne, WhatMany : IP ;                 -- "what (is)", "what (are)"
  FunIP : Fun -> IP -> IP ;                -- "the mother of whom"
  NounIPOne, NounIPMany : CN -> IP ;       -- "which car", "which cars"

  QuestVP : NP -> VP -> Qu ;               -- "does John walk"
  IntVP : IP -> VP -> Qu ;                 -- "who walks"
  IntSlash : IP -> Slash -> Qu ;           -- "whom does John see"
  QuestAdv : IAdv -> NP -> VP -> Qu ;      -- "why do you walk"

  ImperVP : VP -> Imp ;                    -- "be a man"

  IndicPhrase : S -> Phr ;                 -- "I walk."
  QuestPhrase : Qu -> Phr ;                -- "Do I walk?"
  ImperOne, ImperMany : Imp -> Phr ;       -- "Be a man!", "Be men!"

  AdvS : AdS -> S -> Phr ;                 -- "Therefore, 2 is prime."

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

--3 Subordination
--
-- Subjunctions are different from conjunctions, but form
-- a uniform category among themselves.

  SubjS     : Subj -> S -> S -> S ;        -- "if 2 is odd, 3 is even"
  SubjImper : Subj -> S -> Imp -> Imp ;    -- "if it is hot, use a glove!"
  SubjQu    : Subj -> S -> Qu -> Qu ;      -- "if you are new, who are you?"

--2 One-word utterances
--
-- These are, more generally, *one-phrase utterances*. The list below
-- is very incomplete.

  PhrNP : NP -> Phr ;                      -- "Some man.", "John."
  PhrOneCN, PhrManyCN : CN -> Phr ;        -- "A car.", "Cars."
  PhrIP : IAdv -> Phr ;                    -- "Who?"
  PhrIAdv : IAdv -> Phr ;                  -- "Why?"

--2 Text formation
--
-- A text is a sequence of phrases. It is defined like a non-empty list.
  
  OnePhr  : Phr -> Text ;
  ConsPhr : Phr -> Text -> Text ;

--2 Examples of structural words
-- 
-- Here we have some words belonging to closed classes and appearing
-- in all languages we have considered.
-- Sometimes they are not really meaningful, e.g. $TheyNP$ in French
-- should really be replaced by masculine and feminine variants.

  EveryDet, AllDet, WhichDet, MostDet : Det ; -- every, all, which, most
  INP, ThouNP, HeNP, SheNP, ItNP : NP ;       -- personal pronouns in singular
  WeNP, YeNP, TheyNP : NP ;                   -- personal pronouns in plural
  YouNP : NP ;                                -- the polite you
  WhenIAdv,WhereIAdv,WhyIAdv,HowIAdv : IAdv ; -- when, where, why, how
  AndConj, OrConj : Conj ;                    -- and, or
  BothAnd, EitherOr, NeitherNor : ConjD ;     -- both-and, either-or, neither-nor
  IfSubj, WhenSubj : Subj ;                   -- if, when
  PhrYes, PhrNo : Phr ;                       -- yes, no
  VeryAdv, TooAdv : AdA ;                     -- very, too
  OtherwiseAdv, ThereforeAdv : AdS ;          -- therefore, otherwise            
} ;

