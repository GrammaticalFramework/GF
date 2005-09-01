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

concrete CategoriesEng of Categories = PredefCnc ** open Prelude, SyntaxEng in {

lincat 
  N      = CommNoun ;         
      -- = {s : Number => Case => Str}
  CN     = CommNounPhrase ;   
      -- = CommNoun ** {g : Gender}
  NP     = {s : NPForm => Str ; a : Agr} ;
  PN     = {s : Case => Str ; g : Gender} ;
  Det    = {s : Str ; n : Number} ;
  NDet   = {s : Str} ;
  N2     = Function ;
      -- = CommNounPhrase ** {s2 : Preposition} ;
  N3     = Function ** {s3 : Preposition} ;
  Num    = {s : Case => Str ; n : Number} ;
  Prep   = {s : Str} ;

  A      = Adjective ; 
      -- = {s : AForm => Str}
  A2     = Adjective ** {s2 : Preposition} ;
  ADeg   = {s : Degree => AForm => Str} ;
  AP     = {s : Agr => Str ; p : Bool} ;
  AS     = Adjective ; --- "more difficult for him to come than..."
  A2S    = Adjective ** {s2 : Preposition} ;
  AV     = Adjective ;
  A2V    = Adjective ** {s2 : Preposition} ;

  V      = Verb ; 
      -- = {s : VForm => Str ; s1 : Particle}
  VP     = {s,s2 : Bool => SForm => Agr => Str ; isAux : Bool} ;
  VPI    = {s : VIForm => Agr => Str ; s1 : Str} ; -- s1 is "not" or []
  VCl    = {s : Bool => Anteriority => VIForm => Agr => Str ; s1 : Bool => Str} ;
  V2     = TransVerb ; 
      -- = Verb ** {s3 : Preposition} ;
  V3     = TransVerb ** {s4 : Preposition} ;
  VS     = Verb ;
  VV     = AuxVerb ** {isAux : Bool} ;

  VS     = Verb ;
  VQ     = Verb ;
  VA     = Verb ;

  V2S    = TransVerb ;
  V2Q    = TransVerb ;
  V2V    = TransVerb ** {s4 : Str} ;
----V2V    = {s : VForm => Str ; s1 : Particle ; s3, s4 : Str} ;
  V2A    = TransVerb ;
  V0     = Verb ;

  TP     = {s : Str ; b : Bool ; t : Tense ; a : Anteriority} ; --- the Str field is dummy
  Tense  = {s : Str ; t : Tense} ;
  Pol    = {s : Str ; p : Bool} ;
  Ant    = {s : Str ; a : Anteriority} ;

  PP     = {s : Str} ;
  Adv    = {s : Str} ;
  AdV    = {s : Str} ;
  AdA    = {s : Str} ;
  AdC    = {s : Str} ;

  S      = {s : Str} ; 
  Cl     = Clause ;
      -- = {s : Order => Bool => SForm => Str} ;
  Slash  = {s : QuestForm => Bool => SForm => Str ; s2 : Preposition} ;
  RP     = {s : Gender => Number => NPForm => Str} ;
  RCl    = {s : Bool => SForm => Agr => Str} ;
  RS     = {s :                  Agr => Str} ;

  IP     = {s : NPForm => Str ; n : Number ; g : Gender} ;
  IDet   = {s : Str ; n : Number} ;
  IAdv   = {s : Str} ;
  QCl    = {s : Bool => SForm => QuestForm => Str} ;
  QS     = {s :                  QuestForm => Str} ;
  Imp    = {s : Number => Str} ;
  Phr    = {s : Str} ;
  Text   = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1 : Str ; s2 : Str} ;
  ListAP = {s1,s2 : Agr => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; a : Agr} ;
  ListAdv = {s1 : Str ; s2 : Str} ;

} ;
