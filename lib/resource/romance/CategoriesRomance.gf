--# -path=.:../abstract:../../prelude

--1 The Top-Level French Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the French concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file 
-- $syntax.Romance.gf$, some in $syntax.Fra.gf$.
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
-- implemented. Most parameter types are defined in $TypesRomance$, some in
-- $TypesFra$ and $TypesIta$.

incomplete concrete CategoriesRomance of Categories = 
  PredefCnc ** open Prelude, SyntaxRomance in {

flags 
  startcat=Phr ; optimize=all ;

lincat 
  N      = CommNoun ; 
      -- = {s : Number => Str ; g : Gender} ;
  CN     = CommNoun ; 
  NP     = {s : NPFormA => Str ; g : PronGen ; 
            n : Number ; p : Person ; c : ClitType} ;
  PN     = {s : Str ; g : Gender} ;
  Det    = {s : Gender => Str ; n : Number} ;
  NDet   = {s : Gender => Str} ;
  N2     = Function ;
      -- = CommNoun ** {s2 : Preposition ; c : CaseA} ;
  N3     = Function ** {s3 : Preposition ; c3 : CaseA} ;
  Prep   = {s : Preposition ; c : CaseA} ; 
  Num    = {s : Gender => Str ; n : Number ; isNo : Bool} ;

  A      = Adjective ;
      -- = {s : AForm => Str ; p : Bool} ;
  A2     = Adjective ** {s2 : Preposition ; c : CaseA} ;
  ADeg   = {s : Degree => AForm => Str ; p : Bool} ;
  AP     = Adjective ;
  AS     = Adjective ** {mp,mn : Mode} ; --- "more difficult for him to come than..."
  A2S    = Adjective ** {mp,mn : Mode ; c : CaseA ; s2 : Preposition} ;
  AV     = Adjective ** {c : CaseA ; s2 : Preposition} ;
  A2V    = Adjective ** {c : CaseA ; s2 : Preposition} ;

  V      = Verb ; 
      -- = {s : VF => Str} ;
  VP     = {s : Bool => Gender => VPForm => Str} ;
  VPI    = {s : VIForm => Gender => Number => Person => Str} ;
  V2     = TransVerb ;
      -- = Verb ** {s2 : Preposition ; c : CaseA} ; 
  V3     = TransVerb ** {s3 : Preposition ; c3 : CaseA} ;
  VS     = Verb ** {mp,mn : Mode} ;
  VV     = Verb ** {c : CaseA} ;
  VQ     = Verb ;
  VA     = Verb ;

  V2S    = TransVerb ** {mp,mn : Mode} ;
  V2Q    = TransVerb ;
  V2V    = TransVerb ** {c3 : CaseA ; s3 : Preposition} ;
  V2A    = TransVerb ;
  V0     = Verb ;

  TP     = {s : Str ; b : Bool ; t : Tense ; a : Anteriority} ; --- s-field is dummy
  Tense  = {s : Str ; t : Tense} ;
  Ant    = {s : Str ; a : Anteriority} ;

  Adv    = {s : Str} ;
  AdV    = {s : Str} ;
  AdA    = {s : Str} ;
  AdC    = {s : Str} ;
  PP     = {s : Str} ;

  S      = Sentence ; 
      -- = {s : Mode => Str} ;
  Cl     = Clause ;
      -- = {s : Bool => ClForm => Str} ;
  Slash  = Clause ** {s2 : Preposition ; c : CaseA} ;

  RP     = {s : RelForm => Str ; g : RelGen} ;
  RS     = {s :           Mode => Gender => Number => Person => Str} ;
  RCl    = {s : Bool => ClForm => Gender => Number => Person => Str} ;

  IP     = {s : CaseA => Str ; g : Gender ; n : Number} ;
  IDet   = {s : Gender => Str ; n : Number} ;
  QS     = {s :                   QuestForm => Str} ;
  QCl    = {s : Bool => ClForm => QuestForm => Str} ;
  Imp    = {s : Gender => Number => Str} ;

  Phr    = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1,s2 : Str ; n : Number} ;

  ListS   = {s1,s2 : Mode => Str} ;
  ListAP  = {s1,s2 : AForm => Str ; p : Bool} ;
  ListNP  = {s1,s2 : CaseA => Str ; g : PronGen ; n : Number ; p : Person} ;
  ListAdv = {s1,s2 : Str} ; 

  Subj    = {s : Str ; m : Mode} ;

}
