--1 English Word Classes and Morphological Parameters
--
-- This is a resource module for English morphology, defining the
-- morphological parameters and word classes of English. It is aimed
-- to be complete w.r.t. the description of word forms.
-- However, it only includes those parameters that are needed for
-- analysing individual words: such parameters are defined in syntax modules.
--
-- we use the language-independent prelude.

resource Types = open Prelude in {

--
--2 Enumerated parameter types 
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param 
  Number = Sg | Pl ;
  Gender = NoHum | Hum ;
  Case   = Nom | Gen ;
  Person = P1 | P2 | P3 ;
  Degree = Pos | Comp | Sup ;

-- For data abstraction, we define

oper 
  singular = Sg ;
  plural = Pl ;

--2 Word classes and hierarchical parameter types
--
-- Real parameter types (i.e. ones on which words and phrases depend) 
-- are often hierarchical. The alternative would be cross-products of
-- simple parameters, but this would usually overgenerate.
--

--3 Common nouns
--
-- Common nouns are inflected in number and case.

  CommonNoun : Type = {s : Number => Case => Str} ;


--
--3 Adjectives
--
-- The major division is between the comparison degrees, but it
-- is also good to leave room for adjectives that cannon be compared.
-- Such adjectives are simply strings.

  Adjective : Type = SS ;
  AdjDegr = SS1 Degree ;

--3 Verbs
--
-- We treat the full conjugation now.
-- The present tense is made to depend on person, which correspond to forms
-- in the singular; plural forms are uniformly equal to the 2nd person singular.

param
  VForm = InfImp | Indic Person | Past Number | PPart ;

oper
  VerbP3 : Type = SS1 VForm ;

-- A full verb can moreover have a particle.

  Particle : Type = Str ;
  Verb = VerbP3 ** {s1 : Particle} ; 

--
--3 Pronouns
--
-- For pronouns, we need four case forms: "I" - "me" - "my" - "mine".

param
  NPForm = NomP | AccP | GenP | GenSP ; 

oper
  Pronoun  : Type = {s : NPForm => Str ; n : Number ; p : Person} ;

-- Coercions between pronoun cases and ordinaty cases.

  toCase  : NPForm -> Case = \c -> case c of {GenP => Gen ; _ => Nom} ;
  toNPForm : Case -> NPForm = \c -> case c of {Gen  => GenP ; _ => NomP} ; ---

--3 Proper names
--
-- Proper names only need two cases.

  ProperName : Type = SS1 Case ;

--3 Relative pronouns
--
-- Relative pronouns are inflected in gender (human/nonhuman), number, and case.

  RelPron : Type = {s : Gender => Number => NPForm => Str} ;
} ;

