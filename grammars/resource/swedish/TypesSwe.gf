--1 Swedish Word Classes and Morphological Parameters
--
-- This is a resource module for Swedish morphology, defining the
-- morphological parameters and word classes of Swedish. It is aimed
-- to be complete w.r.t. the description of word forms.
-- However, it does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.
--
-- This GF grammar was obtained from the functional morphology file TypesSw.hs
-- semi-automatically. The GF inflection engine obtained was obtained automatically.

resource TypesSwe = open Prelude in {

--

--2 Enumerated parameter types 
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param
  Gender  = Utr | Neutr ;
  Number  = Sg | Pl ;
  Species = Indef | Def ;
  Case    = Nom | Gen ;
  Sex     = NoMasc | Masc ;
  Mode    = Ind | Cnj ;
  Voice   = Act | Pass ;
  Degree  = Pos | Comp | Sup ;
  Person  = P1 | P2 | P3 ;

--2 Word classes and hierarchical parameter types
--
-- Real parameter types (i.e. ones on which words and phrases depend) 
-- are mostly hierarchical. The alternative would be cross-products of
-- simple parameters, but this would usually overgenerate.
--

--3 Substantives
--
-- Substantives (= common nouns) have a parameter of type SubstForm.

param SubstForm = SF Number Species Case ;

-- Substantives moreover have an inherent gender. 

oper Subst : Type = {s : SubstForm => Str ; h1 : Gender} ;

--3 Adjectives
--
-- Adjectives are a very complex class, and the full table has as many as
-- 18 different forms. The major division is between the comparison degrees;
-- the comparative has only the 2 case forms, whereas the positive has 12 forms.

param
  AdjForm = AF AdjFormGrad Case ;

-- The positive strong forms depend on gender: "en stor bil" - "ett stort hus".
-- But the weak forms depend on sex: "den stora bilen" - "den store mannen".
-- The plural never makes a gender-sex distinction.

  GenNum = ASg Gender | APl ;
  SexNum = AxSg Sex | AxPl ;

  AdjFormPos = Strong GenNum | Weak SexNum ;
  AdjFormSup = SupStrong | SupWeak ;

  AdjFormGrad =
    Posit  AdjFormPos
  | Compar  
  | Super AdjFormSup ;

oper 
  Adj : Type = {s : AdjForm => Str} ;

--3 Verbs
--
-- Verbs have 9 finite forms and as many as 18 infinite forms; the large number
-- of the latter comes from adjectives. 

oper Verbum : Type = {s : VerbForm => Str} ;

param
  VFin = 
   Pres Mode Voice
 | Pret Mode Voice
 | Imper ;         --- no passive
 
  VInf =
   Inf Voice
 | Supin Voice
 | PtPres Case
 | PtPret AdjFormPos Case ;

  VerbForm = 
   VF VFin
 | VI VInf ;

-- However, the syntax only needs a simplified verb category, with 
-- present tense only. Such a verb can be extracted from the full verb,
-- and a choice can be made between an active and a passive (deponent) verb.
-- Active verbs continue to have passive forms.

param
  VMode = Infinit | Indicat | Imperat ;
  VForm = VPres VMode Voice ;

oper
  Verb : Type = SS1 VForm ;

  extVerb : Voice -> Verbum -> Verb = \v,verb -> {s = table { 
    VPres Infinit v    => verb.s ! VI (Inf v) ;
    VPres Indicat v    => verb.s ! VF (Pres Ind v) ;
    VPres Imperat Act  => verb.s ! VF Imper ; 
    VPres Imperat Pass => verb.s ! VF (Pres Ind Pass)   --- no passive in Verbum
    }} ;

--3 Other open classes
--
-- Proper names, adverbs (Adv having comparison forms and AdvIn not having them),
-- and interjections are the remaining open classes.

oper 
  PNm    : Type = {s : Case => Str ; h1 : Gender} ;
  Adv    : Type = {s : Degree => Str} ;
  AdvInv : Type = {s : Str} ;
  Interj : Type = {s : Str} ;
  
--3 Closed classes
--
-- The rest of the Swedish word classes are closed, i.e. not extensible by new
-- lexical entries. Thus we don't have to know how to build them, but only
-- how to use them, i.e. which parameters they have.
--
-- The most important distinction is between proper-name-like pronouns and
-- adjective-like pronouns, which are inflected in completely different parameters.

param 
  NPForm      = PNom | PAcc | PGen GenNum ;
  AdjPronForm = APron GenNum Case ;
  AuxVerbForm = AuxInf | AuxPres | AuxPret | AuxSup ;

oper 
  ProPN    : Type = {s : NPForm => Str ; h1 : Gender ; h2 : Number ; h3 : Person} ;
  ProAdj   : Type = {s : AdjPronForm => Str} ;
  Prep     : Type = {s : Str} ;
  Conjunct : Type = {s : Str} ;
  Subjunct : Type = {s : Str} ;
  Art      : Type = {s : GenNum => Str} ;
  Part     : Type = {s : Str} ;
  Infin    : Type = {s : Str} ;
  VAux     : Type = {s : AuxVerbForm => Str} ;
}
