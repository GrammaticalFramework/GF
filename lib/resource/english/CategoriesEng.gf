--# -path=.:../abstract:../../prelude

--1 The Top-Level English Resource Grammar: Combination Rules
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the English concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.Eng.gf$.
-- However, for the purpose of documentation, we make here explicit the
-- linearization types of each category, so that their structures and
-- dependencies can be seen.
-- Another substantial part are the linearization rules of some
-- structural words.
--
-- The users of the resource grammar should not look at this file for the
-- linearization rules, which are in fact hidden in the document version.
-- They should use $resource.Abs.gf$ to access the syntactic rules.
-- This file can be consulted in those, hopefully rare, occasions in which
-- one has to know how the syntactic categories are
-- implemented. The parameter types are defined in $TypesEng.gf$.

concrete CategoriesEng of Categories = open Prelude, SyntaxEng in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lincat 
  N      = CommNoun ;         
      -- = {s : Number => Case => Str}
  CN     = CommNounPhrase ;   
      -- = CommNoun ** {g : Gender}
  NP     = {s : NPForm => Str ; n : Number ; p : Person} ;
  PN     = {s : Case => Str} ;
  Det    = {s : Str ; n : Number} ;
  N2     = Function ;
      -- = CommNounPhrase ** {s2 : Preposition} ;
  N3     = Function ** {s3 : Preposition} ;
  Num    = {s : Case => Str} ;
  Prep   = {s : Str} ;

  A      = Adjective ; 
      -- = {s : AForm => Str}
  A2     = Adjective ** {s2 : Preposition} ;
  ADeg   = {s : Degree => AForm => Str} ;
  AP     = Adjective ** {p : Bool} ;

  V      = Verb ; 
      -- = {s : VForm => Str ; s1 : Particle}
  VG     = {s,s2 : Bool => VPForm => Str ; s3 : Number => Str ; isAux : Bool} ;
  VP     = {s,s2 :         VPForm => Str ; s3 : Number => Str ; isAux : Bool} ;
  TV     = TransVerb ; 
      -- = Verb ** {s3 : Preposition} ;
  V3     = TransVerb ** {s4 : Preposition} ;
  VS     = Verb ;
  VV     = Verb ** {isAux : Bool} ;

  AdV    = {s : Str ; p : Bool} ;

  S      = {s : Str} ; 
  Cl     = Clause ;
      -- = {s : Bool => SForm => Str} ;
  Slash  = {s : Bool => Str ; s2 : Preposition} ;
  RP     = {s : Gender => Number => NPForm => Str} ;
  RC     = {s : Gender => Number => Str} ;

  IP     = {s : NPForm => Str ; n : Number} ;
-----  Qu     = {s : QuestForm => Str} ;
  Imp    = {s : Number => Str} ;
  Phr    = {s : Str} ;
  Text   = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1 : Str ; s2 : Str} ;
  ListAP = {s1,s2 : AForm => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; n : Number ; p : Person} ;

} ;
