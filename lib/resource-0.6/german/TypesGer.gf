--1 German Word Classes and Morphological Parameters
--
-- This is a resource module for German morphology, defining the
-- morphological parameters and word classes of German. It is so far only
-- complete w.r.t. the syntax part of the resource grammar.
-- It does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.
--

resource TypesGer = open Prelude in {

--2 Enumerated parameter types 
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param 
  Number = Sg | Pl ;
  Gender = Masc | Fem | Neut ;
  Person = P1 | P2 | P3 ;
  Case   = Nom | Acc | Dat | Gen ;
  Adjf   = Strong | Weak ;          -- the main division in adjective declension
  Order  = Main | Inv | Sub ;       -- word order: direct, indirect, subordinate

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
-- Common nouns are inflected in number and case and they have an inherent gender.

  CommNoun : Type = {s : Number => Case => Str ; g : Gender} ;

--3 Pronouns
--
-- Pronouns are an example - the worst-case one of noun phrases,
-- which are properly defined in $syntax.Deu.gf$.
-- Their inflection tables has, in addition to the normal genitive,
-- the possessive forms, which are inflected like determiners.

param
  NPForm = NPCase Case | NPPoss GenNum Case ;

--3 Adjectives
--
-- Adjectives are a very complex class, and the full table has as many as
-- 99 different forms. The major division is between the comparison degrees.
-- There is no gender distinction in the plural, 
-- and the predicative forms ("X ist Adj") are not inflected.

param
  GenNum = GSg Gender | GPl ;
  AForm  = APred | AMod Adjf GenNum Case ;  

oper
  Adjective : Type = {s : AForm => Str} ;
  AdjComp : Type = {s : Degree => AForm => Str} ;

-- Comparison of adjectives:

param Degree = Pos | Comp | Sup ;

--3 Verbs 
--
-- We have a reduced conjugation with only the present tense infinitive, 
-- indicative, and imperative forms, and past participles.

param VForm = VInf | VInd Number Person | VImp Number | VPart AForm ;

oper Verbum : Type = VForm => Str ;

-- On the general level, we have to account for composite verbs as well, 
-- such as "aus" + "sehen" etc.

  Particle = Str ;

  Verb = {s : Verbum ; s2 : Particle} ;


--2 Prepositions
--
-- We define prepositions simply as strings. Thus we do not capture the
-- contractions "vom", "ins", etc. To define them in GF grammar we would need
-- to introduce a parameter system, which we postpone.

  Preposition = Str ;

} ;
