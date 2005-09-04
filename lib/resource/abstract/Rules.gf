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
  NDetNP      : NDet -> Num -> CN -> NP ;  -- "these (5) cars"
  NDetNum     : NDet -> Num ->       NP ;  -- "these (5)"
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
  SuperlADeg  : ADeg -> AP ;               -- "the oldest"

  ComplAV     : AV  -> VPI -> AP ;         -- "eager to leave"
  ComplObjA2V : A2V -> NP -> VPI -> AP ;   -- "easy for us to convince"



--!
--3 Verbs and verb phrases
--
-- The main uses of verbs and verb phrases have been moved to the
-- module $Verbphrase$ (deep $VP$ nesting) and its alternative,
-- $Clause$ (shallow many-place predication structure).

  PredAS       : AS -> S  -> Cl ;          -- "it is good that he comes"                
  PredV0       : V0 -> Cl ;                -- "it is raining"

-- Partial saturation.

  UseV2        : V2 -> V ;                 -- "loves"

  ComplA2S     : A2S -> NP  -> AS ;        -- "good for John"

  UseV2V : V2V -> VV ;
  UseV2S : V2S -> VS ;
  UseV2Q : V2Q -> VQ ;
  UseA2S : A2S -> AS ;
  UseA2V : A2V -> AV ;

-- Formation of tensed phrases.

  AdjPart : V -> A ;                       -- past participle, e.g. "forgotten"

  UseCl  : TP -> Cl  -> S ;
  UseRCl : TP -> RCl -> RS ;
  UseQCl : TP -> QCl -> QS ;

  UseVCl : Pol -> Ant -> VCl -> VPI ;

  PosTP  : Tense -> Ant -> TP ;
  NegTP  : Tense -> Ant -> TP ;

  TPresent : Tense ;
  TPast    : Tense ;
  TFuture  : Tense ;
  TConditional : Tense ;

  ASimul   : Ant ;
  AAnter   : Ant ;

  PPos : Pol ;
  PNeg : Pol ;

--!
--3 Adverbs
--
-- Here is how complex adverbs can be formed and used.

  AdjAdv : A -> Adv ;                  -- "freely"
  AdvPP  : PP -> Adv ;                 -- "in London", "after the war"
  PrepNP : Prep -> NP -> PP ;          -- "in London", "after the war"

  AdvCN  : CN  -> Adv -> CN ;          -- "house in London"
  AdvNP  : NP  -> Adv -> NP ;          -- "the house in London"
  AdvAP  : AdA -> AP -> AP ;           -- "very good"
  AdvAdv : AdA -> Adv -> Adv ;         -- "very well"


--!
--3 Sentences and relative clauses
--

  SlashV2  : NP -> V2 -> Slash ;       -- "(whom) John doesn't love"
  SlashVV2 : NP -> VV -> V2 -> Slash ; -- "(which song do you) want to play"
  SlashAdv : Cl -> Prep -> Slash ;     -- "(whom) John walks with"

  IdRP     : RP ;                      -- "which"
  FunRP    : N2 -> RP -> RP ;          -- "the successor of which"
  RelSlash : RP -> Slash -> RCl ;      -- "that I wait for"/"for which I wait" 
  ModRS    : CN -> RS -> CN ;          -- "man who walks"
  RelCl    : Cl -> RCl ;               -- "such that it is even"

--!
--3 Questions and imperatives
--

  FunIP  : N2 -> IP -> IP ;                 -- "the mother of whom"
  IDetCN : IDet -> CN -> IP ;               -- "which car", "which cars"

  QuestCl    : Cl -> QCl ;                  -- "does John walk"; "doesn't John walk"
  IntSlash   : IP -> Slash -> QCl ;         -- "whom does John see"
  QuestAdv   : IAdv -> Cl -> QCl ;          -- "why do you walk"

  PosImpVP, NegImpVP : VCl -> Imp ;         -- "(don't) be a man"

----rename these ??
  IndicPhrase : S -> Phr ;                  -- "I walk."
  QuestPhrase : QS -> Phr ;                 -- "Do I walk?"
  ImperOne, ImperMany : Imp -> Phr ;        -- "Be a man!", "Be men!"

  AdvCl  : Cl  -> Adv -> Cl ;               -- "John walks in the park"
  AdvVPI : VPI -> Adv -> VPI ;              -- "walk in the park"
  AdCPhr : AdC -> S -> Phr ;                -- "Therefore, 2 is prime."
  AdvPhr : Adv -> S -> Phr ;                -- "In India, there are tigers."

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

  ConjS    : Conj -> ListS -> S ;            -- "John walks and Mary runs"
  ConjAP   : Conj -> ListAP -> AP ;          -- "even and prime"
  ConjNP   : Conj -> ListNP -> NP ;          -- "John or Mary"
  ConjAdv  : Conj -> ListAdv -> Adv ;        -- "quickly or slowly"

  ConjDS   : ConjD -> ListS -> S ;           -- "either John walks or Mary runs"
  ConjDAP  : ConjD -> ListAP -> AP ;         -- "both even and prime"
  ConjDNP  : ConjD -> ListNP -> NP ;         -- "either John or Mary"
  ConjDAdv : ConjD -> ListAdv -> Adv ;       -- "both badly and slowly"

  TwoS  : S -> S -> ListS ;
  ConsS : ListS -> S -> ListS ;

  TwoAP  : AP -> AP -> ListAP ;
  ConsAP : ListAP -> AP -> ListAP ;

  TwoNP  : NP -> NP -> ListNP ;
  ConsNP : ListNP -> NP -> ListNP ;

  TwoAdv  : Adv -> Adv -> ListAdv ;
  ConsAdv : ListAdv -> Adv -> ListAdv ;

--!
--3 Subordination
--
-- Subjunctions are different from conjunctions, but form
-- a uniform category among themselves.

  SubjS     : Subj -> S -> S -> S ;        -- "if 2 is odd, 3 is even"
  SubjImper : Subj -> S -> Imp -> Imp ;    -- "if it is hot, use a glove!"
  SubjQS    : Subj -> S -> QS -> QS ;      -- "if you are new, who are you?"

-- This rule makes a subordinate clause into a sentence adverb, which
-- can be attached to e.g. noun phrases. It might even replace the
-- previous subjunction rules.

  AdvSubj   : Subj -> S -> Adv ;           -- "when he arrives"

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

  OneNP      : NP ;                             -- "one (walks)"

} ;
