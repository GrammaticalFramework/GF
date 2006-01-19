--1 Romance Word Classes and Morphological Parameters
--

resource ParamRomance = ParamX ** open Prelude in {

-- This is a resource module for Romance grammars, currently instantiated for
-- French, Italian, and Spanish. It defines the
-- morphological parameters that are common to all Romance languages.
-- The guiding principle has been
-- to share as much as possible, which has two advantages: it saves work in
-- encoding, and it shows how the languages are related.
-- Those parameters that differ are defined in [DiffRomance DiffRomance.html].
-- Some parameters are shared even more widely, such as $Number$ and $Person$.
-- They are defined in [ParamX ParamX.html].


--2 Enumerated parameter types for morphology
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param

  Gender = Masc | Fem ;

  Mood   = Indic | Conjunct ;

-- There are different types of clicic pronouns (as for position).
-- Examples of each: "Giovanni" ; "io" ; "lui" ; "noi".

  ClitType = Clit0 | Clit1 | Clit2 | Clit3 ;

-- Adjectives are inflected in gender and number, and there is also an 
-- adverbial form (e.g. "infiniment"), which has different paradigms and 
-- can even be irregular ("bien").
-- Comparative adjectives are moreover inflected in degree
-- (which in Romance is usually syntactic, though).

  AForm = AF Gender Number | AA ;

-- Gender is not morphologically determined for first and second person pronouns.

  PronGen = PGen Gender | PNoGen ;

-- The following coercions are useful:

oper
  prongen2gender : PronGen -> Gender = \p -> case p of {
    PGen g => g ;
    PNoGen => variants {Masc ; Fem} --- the best we can do for je, tu, nous, vous
    } ;


  aform2gender : AForm -> Gender = \a -> case a of {
    AF g _ => g ;
    _      => Masc -- "le plus lentement"
    } ;
  aform2number : AForm -> Number = \a -> case a of {
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
   | VFin   TMood Number Person 
   | VImper NumPersI 
   | VPart  Gender Number 
   | VGer
   ;

  TMood = 
     VPres   Mood
   | VImperf Mood
   | VPasse
   | VFut
   | VCondit
   ;

  NumPersI  = SgP2 | PlP1 | PlP2 ;

-- Agreement of adjectives, verb phrases, and relative pronouns.

oper
  AAgr : Type = {g : Gender ; n : Number} ;
  Agr  : Type = AAgr ** {p : Person} ;

param
  RAgr = RAg AAgr | RNoAg ;

oper
  aagr : Gender -> Number -> AAgr = \g,n ->
    {g = g ; n = n} ;
  agrP3 : Gender -> Number -> Agr = \g,n ->
    aagr g n ** {p = P3} ;


  vf2numpers : VF -> (Number * Person) = \v -> case v of {
    VFin _ n p => <n,p> ;
    _ => <Sg,P3> ----
    } ;

  presInd = VPres Indic ;

-- The imperative forms depend on number and person.

  vImper : Number -> Person -> VF = \n,p -> case <n,p> of {
    <Sg,P2> => VImper SgP2 ; 
    <Pl,P1> => VImper PlP1 ; 
    <Pl,P2> => VImper PlP2 ;
    _       => VInfin
    } ; 

}
