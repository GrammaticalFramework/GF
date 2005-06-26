--# -path=.:../abstract:../../prelude

--1 The Top-Level Finnish Resource Grammar: Linearization Types
--
-- Aarne Ranta 2002 -- 2005
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

concrete CategoriesFin of Categories = PredefCnc ** open Prelude, SyntaxFin in {

lincat 
  N      = CommNoun ;    
      -- = {s : NForm => Str ; g : Gender}
  CN     = CommNounPhrase ;   
  NP     = {s : NPForm => Str ; n : Number ; p : NPPerson} ;
  PN     = {s : Case => Str} ;
  Det    = {s : Gender => Case => Str ; n : Number ; isNum : Bool} ;
  NDet   = {s : Gender => Case => Str ;              isNum : Bool} ;
  N2     = Function ;
      -- = CommNounPhrase ** {c : NPForm} ;
  N3     = Function ** {c2 : NPForm} ;
  Num    = {s : NPForm => Str ; isNum : Bool ; n : Number} ;
  Prep   = {s : Str ; c : Case ; isPrep : Bool} ;

  A      = Adjective ; 
      -- = CommonNoun ;
  A2     = Adjective ** {c : NPForm} ;
  ADeg   = {s : Degree => AForm => Str} ;
  AP     = {s : AdjPos => AForm => Str} ;
  AS     = Adjective ; --- "more difficult for him to come than..."
  A2S    = Adjective ** {c : NPForm} ;
  AV     = Adjective ;
  A2V    = Adjective ** {c : NPForm} ;

  V      = Verb ; 
      -- = {s : VForm => Str}
----  VP     = {s,s2 : Bool => SForm => Agr => Str ; isAux : Bool} ;
  VPI    = {s : VIForm => Str} ; 
-----  VP     = Verb ** {s2 : VForm => Str ; c : ComplCase} ;
----  VG     = {s,s2 : Bool => VForm => Str ; c : ComplCase} ;
  V2     = TransVerb ;
      -- = Verb ** {s3, s4 : Str ; c : ComplCase} ;
  V3     = TransVerb ** {s5, s6 : Str ; c2 : ComplCase} ;
  VS     = Verb ;
  VV     = Verb ** {c : ComplCase} ;
  VQ     = Verb ;
  VA     = Verb ** {c : Case} ;

  V2S    = TransVerb ;
  V2Q    = TransVerb ;
  V2V    = TransVerb ; ----
  V2A    = TransVerb ** {c2 : Case} ;
  V0     = Verb ;

  TP     = {s : Str ; b : Bool ; t : Tense ; a : Anteriority} ; --- the Str field is dummy
  Tense  = {s : Str ; t : Tense} ;
  Ant    = {s : Str ; a : Anteriority} ;

  PP     = {s : Str} ;
  Adv    = {s : Str} ;
  AdV    = {s : Str} ;
  AdA    = {s : Str} ;
  AdC    = {s : Str} ;

  S      = {s : Str} ; 
  Cl     = Clause ;
      -- = {s : Bool => SForm => Str} ;

  Slash  = Sentence ** {s2 : Str ; c : Case} ;

  RP     = {s : Number => Case => Str} ;
----  RCl    = {s : Bool => SForm => Agr => Str} ;
  RS     = {s : Number => Str} ;

  IP     = {s : NPForm => Str ; n : Number} ;
  IDet   = {s : Gender => Case => Str ; n : Number} ;
  IAdv   = {s : Str} ;
  QCl    = {s : Bool => SForm => Str} ;
  QS     = {s : Str} ;
  Imp    = {s : Number => Str} ;
  Phr    = {s : Str} ;
  Text   = {s : Str} ;

  Subj   = {s : Str} ;
  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1 : Str ; s2 : Str} ;
  ListAP = {s1,s2 : AdjPos => AForm => Str} ;
  ListNP = {s1,s2 : NPForm => Str ; n : Number ; p : NPPerson} ;
  ListAdv = {s1 : Str ; s2 : Str} ;

} ;
