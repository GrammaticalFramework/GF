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


abstract Categories = PredefAbs ** {
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

  Adv ;    -- adverbial              e.g. "now", "in the house"
  AdA ;    -- ad-adjective           e.g. "very"
  AdS ;    -- sentence adverbial     e.g. "therefore", "otherwise"
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

}
