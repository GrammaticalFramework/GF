--# -path=.:../abstract:../../prelude

--1 The Top-Level Swedish Resource Grammar: Combination Rules
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the Swedish concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $SyntaxSwe.gf$.
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
-- implemented. The parameter types are defined in $TypesSwe.gf$.

concrete CategoriesSwe of Categories = open Prelude, SyntaxSwe in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lincat 
  CN     = {s : Number => SpeciesP => Case => Str ; g : Gender ; x : Sex ; 
            p : IsComplexCN} ;
  N      = CommNoun ;
      -- = {s : Number => Species => Case => Str ; g : Gender ; x : Sex} ;
  NP     = NounPhrase ;
      -- = {s : NPForm => Str ; g : Gender ; n : Number} ;
  PN     = {s : Case => Str ; g : Gender ; x : Sex} ;
  Det    = {s : Gender => Sex => Str ; n : Number ; b : SpeciesP} ;
  N2     = Function ;
      -- = CommNoun ** {s2 : Preposition} ;
  N3     = Function ** {s3 : Preposition} ;
  Num    = {s : Case => Str} ;
  Prep   = {s : Str} ;

  A      = Adjective ;
      -- = {s : AdjFormPos => Case => Str} ; 
  A2     = Adjective ** {s2 : Preposition} ;
  ADeg   = {s : AdjForm => Str} ;
  AP     = Adjective ** {p : IsPostfixAdj} ;

  V      = Verb ;
      -- = {s : VerbForm => Str ; s1 : Str} ;
  VG     = {s : SForm => Str ; s2 : Bool => Str ; s3 : SForm => Gender => Number => Str} ;
  VP     = {s : SForm => Str ; s2 : Str ; s3 : SForm => Gender => Number => Str} ;
  V2     = TransVerb ; 
      -- = Verb ** {s2 : Preposition} ;
  V3     = TransVerb ** {s3 : Preposition} ;
  VS     = Verb ;
  VV     = Verb ** {isAux : Bool} ;

  Adv    = Adverb ; 
      -- = {s : Str ; isPost : Bool} ;
  PP     = Adverb ;

  S      = Sentence ;
      -- = {s : Order => Str} ;
  Cl     = Clause ;
      -- = {s : Bool => SForm => Order => Str} ;
  Slash  = Sentence ** {s2 : Preposition} ;
  RP     = {s : RelCase => GenNum => Str ; g : RelGender} ;
  RC     = {s : GenNum => Str} ;
  IP     = NounPhrase ;
  Qu     = {s : QuestForm => Str} ;
  Imp    = {s : Number => Str} ;

  Phr    = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1,s2 : Order => Str} ; 
  ListAP = {s1,s2 : AdjFormPos => Case => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; g : Gender ; n : Number} ;
}
