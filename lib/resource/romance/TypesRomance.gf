--1 Romance Word Classes and Morphological Parameters
--
-- This is a resource module for French and Italian morphology, defining the
-- morphological parameters and parts of speech of Romance languages.
-- It is used as the major part of language-specific type systems,
-- defined in $types.Fra.gf$ and $types.Ita.gf$. The guiding principle has been
-- to share as much as possible, which has two advantages: it saves work in
-- encoding, and it shows how the languages are related.

interface TypesRomance = {

--2 Enumerated parameter types for morphology
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  Person = P1 | P2 | P3 ;
  Mode   = Ind | Con ;
  Degree = Pos | Comp ;

-- The case must be made an abstract type, since it varies from language to
-- language. The same concerns those parameter types that depend on case.
-- Certain cases can however be defined.

param
  RelGen = RNoGen | RG Gender ;

oper
  CaseA : PType ;
  NPFormA : PType ;

  nominative : CaseA ;
  accusative : CaseA ; 
  genitive : CaseA ;
  dative : CaseA ;
  prepositional : CaseA ;

  stressed : CaseA -> NPFormA ;
  unstressed : CaseA -> NPFormA ;

  RelFormA : PType ; 

-- The genitive and dative cases are expressed by prepositions, except for
-- clitic pronouns. The accusative case only makes a difference for pronouns.

-- Personal pronouns are the following type:

oper
  Pronoun : Type = {
    s : NPFormA => Str ; 
    g : PronGen ; 
    n : Number ; 
    p : Person ; 
    c : ClitType
    } ;

-- The following coercions are useful:

oper
  pform2case : NPFormA -> CaseA ;
  case2pform, case2pformClit : CaseA -> NPFormA ;

  prepCase : CaseA -> Str ;

  adjCompLong : Adj -> AdjComp ;

  relPronForms : CaseA => Str ;

-- For abstraction and API compatibility, we define two synonyms:

oper 
  singular = Sg ; 
  plural = Pl ;


--2 Word classes and hierarchical parameter types
--
-- Real parameter types (i.e. ones on which words and phrases depend) 
-- are mostly hierarchical. The alternative is cross-products of
-- simple parameters, but this cannot be always used since it overgenerates.
--

--3 Common nouns
--
-- Common nouns are inflected in number, and they have an inherent gender.

  CNom : Type = {s : Number => Str ; g : Gender} ;

--3 Pronouns
--
-- Pronouns are an example - the worst-case one of noun phrases,
-- which are defined in $syntax.Ita.gf$.
-- Their inflection tables has tonic and atonic forms, as well as
-- the possessive forms, which are inflected like determiners.
--
-- Example: "lui, de lui, à lui" - "il,le,lui" - "son,sa,ses".

-- Tonic forms are divided into four classes of clitic type.
-- The first value is used for never-clitic noun phrases.
--
-- Examples of each: "Giovanni" ; "io" ; "lui" ; "noi".

  param ClitType = Clit0 | Clit1 | Clit2 | Clit3 ;

-- Gender is not morphologically determined for first and second person pronouns.

  PronGen = PGen Gender | PNoGen ;

-- The following coercion is useful:

oper
  pgen2gen : PronGen -> Gender = \p -> case p of {
    PGen g => g ;
    PNoGen => variants {Masc ; Fem} --- the best we can do for je, tu, nous, vous
    } ;

--3 Adjectives
--
-- Adjectives are inflected in gender and number, and there is also an adverbial form
-- (e.g. "infiniment"), which has different paradigms and can even be irregular ("bien").
-- Comparative adjectives are moreover inflected in degree
-- (which in French and Italian is usually syntactic, though).

param 
  AForm = AF Gender Number | AA ;

oper
  Adj     : Type = {s : AForm => Str} ;
  AdjComp : Type = {s : Degree => AForm => Str} ;

  genAForm : AForm -> Gender = \a -> case a of {
    AF g _ => g ;
    _      => Masc -- "le plus lentement"
    } ;
  numAForm : AForm -> Number = \a -> case a of {
    AF _ n => n ;
    _      => Sg -- "le plus lentement"
    } ;

--3 Verbs 
--
-- In the current syntax, we use 
-- a reduced conjugation with only the present tense infinitive, 
-- indicative, subjunctive, and imperative forms.
-- But our morphology has full Bescherelle conjunctions:
-- so we use a coercion between full and reduced verbs.
-- The full conjugations and the coercions are defined separately for French
-- and Italian, since they are not identical. The differences are mostly due
-- to Bescherelle structuring the forms in different groups; the
-- gerund and the present participles show real differences.

param 
  VF =
     VInfin
   | VFin   TMode Number Person 
   | VImper NumPersI 
   | VPart  Gender Number 
   ;

  TMode = 
     VPres   Mode
   | VImperf Mode
   | VPasse
   | VFut
   | VCondit
   ;

  NumPersI  = SgP2 | PlP1 | PlP2 ;

-- It is sometimes useful to derive the number of a verb form.

oper
  nombreVerb : VF -> Number = \v -> case v of {
    VFin _ n _ => n ;
    _ => singular ---
    } ;

  personVerb : VF -> Person = \v -> case v of {
    VFin _ _ p => p ;
    _ => P3 ---
    } ;

  presInd = VPres Ind ;
-- The imperative forms depend on number and person.

  vImper : Number -> Person -> VF = \n,p -> case <n,p> of {
    <Sg,P2> => VImper SgP2 ; 
    <Pl,P1> => VImper PlP1 ; 
    <Pl,P2> => VImper PlP2 ;
    _       => VInfin
    } ; 

  Verbum : Type ;

  Verb : Type = {s : VF => Str ; aux : VAux} ;

  verbPres : Verbum -> VAux -> Verb ;

param VAux = AEsse | AHabere ;

}
