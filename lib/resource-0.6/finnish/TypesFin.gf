--1 Finnish Word Classes and Morphological Parameters
--
-- This is a resource module for Finnish morphology, defining the
-- morphological parameters and word classes of Finnish. It is aimed
-- to be complete w.r.t. the description of word forms.
-- However, it only includes those parameters that are needed for
-- analysing individual words: such parameters are defined in syntax modules.
--
-- We use the language-independent prelude.

resource TypesFin = open Prelude in {

--
--2 Enumerated parameter types 
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic. The accusative cases are only
-- defined in syntax; in morphology, there is a special accusative for
-- pronouns.

param 
  Number = Sg | Pl ;
  Case   = Nom | Gen | Part | Transl | Ess 
         | Iness | Elat | Illat | Adess | Ablat | Allat 
         | Abess ; ---- | Comit | Instruct ;
  Person = P1 | P2 | P3 ;
  Degree = Pos | Comp | Sup ;
  Gender = NonHuman | Human ;

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
-- Common nouns are inflected in number and noun case. In noun case, we include
-- forms used in connection with possessive suffixes.

param
  NForm = NCase Number Case 
        | NPossNom | NPossGenPl | NPossTransl Number | NPossIllat Number ;

oper
  CommonNoun : Type = {s : NForm => Str} ;

  useNForm : NForm -> (Number => Case => Str) -> Str = \nf,f -> case nf of {
    NCase n c     => f ! n ! c ;
    NPossNom      => f ! Sg ! Nom ; ---- "iso autoni"; also "isot autoni" etc
    NPossGenPl    => f ! Pl ! Gen ;
    NPossTransl n => f ! n ! Transl ;
    NPossIllat n  => f ! n ! Illat
    } ;


--
--3 Adjectives
--
-- The major division is between the comparison degrees, but it
-- is also good to leave room for adjectives that cannon be compared.
-- Such adjectives are like common nouns, except for the adverbial form.

param
  AForm = AN NForm | AAdv ;

oper
  Adjective : Type = {s : AForm => Str} ;
  AdjDegr   : Type = {s : Degree => AForm => Str} ;

--3 Verbs
--
-- We limit the grammar so far to verbs in the infinitive, second-person 
-- imperative, and present tense indicative active and passive. 
-- A special form is needed for
-- the negated plural imperative.

param
  VForm = 
     Inf
   | Ind Number Person
   | Imper Number
   | ImpNegPl
   | Pass Bool 
   ;

oper
  Verb : Type = SS1 VForm ;

  vFormNeg = Imper Sg ;

  vform2number : VForm -> Number = \v -> case v of {
    Ind n _ => n ;
    Imper n => n ;
    ImpNegPl => Pl ;
    _ => Sg ---
    } ;

--
--3 Pronouns
--
-- For pronouns, we need the noun case forms, plus an accusative.

param
  PForm = PCase Case | PAcc ;

oper
  Pronoun  : Type = {s : PForm => Str ; n : Number ; p : Person} ;

--3 Proper names
--
-- Proper names only need case forms.

  ProperName : Type = SS1 Case ;


--3 Relative pronouns
--
-- Relative pronouns are inflected like nouns, except for possessive suffixes.

  RelPron : Type = {s : Number => Case => Str} ;

} ;
