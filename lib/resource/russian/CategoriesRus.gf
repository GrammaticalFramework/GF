--# -path=.:../abstract:../../prelude

--1 The Top-Level Russian Resource Grammar: Combination Rules
--
-- Aarne Ranta, Janna Khegai 2003 -- 2004
--
-- This is the Russian concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $SyntaxRus.gf$.
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
-- implemented. The parameter types are defined in $TypesRus.gf$.

concrete CategoriesRus of Categories = open Prelude, SyntaxRus in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lincat 
  N      = CommNoun ; 
      -- = {s : SubstForm => Str ; g : Gender ; anim : Animacy } ;
  CN     = CommNounPhrase ; 
      -- = {s : Number => Case => Str; g : Gender; anim : Animacy} ;  
  NP     = NounPhrase ;
      -- = { s : PronForm => Str ; n : Number ; p : Person ;
      --     g: PronGen ; anim : Animacy ;  pron: Bool} ;     
  PN     = ProperName ;
      -- = {s :  Case => Str ; g : Gender ; anim : Animacy} ;
  A1   = Adjective ;
      -- = {s : AdjForm => Str} ;
  A2   = AdjCompl ;
      -- = Adjective ** Complement ;
  ADeg = AdjDegr ;
      -- = {s : Degree => AdjForm => Str} ;
  AP     = AdjPhrase ; 
      -- = Adjective ** {p : IsPostfixAdj} ; 

  Det    = Determiner ;
      -- = Adjective ** {n: Number; g: PronGen; c: Case} ; 
  
  N2    = Function ;  
      -- = CommNounPhrase ** Complement ;
  N3   = Function ** {s3 : Str; c2: Case} ; 
  Num    = Numeral ;
      -- = {s : Case => Gender => Str} ;
  
  V      = Verbum ; 
      -- = {s : VerbForm => Str ; asp : Aspect } ;
  VG     = VerbGroup ;
      -- = Verbum ** { w: Voice; s2 : Bool => Str ; 
      --      s3 : Gender => Number => Str ; negBefore: Bool} ;
  VP     = VerbPhrase ; 
      -- = Verb ** {s2 : Str ; s3 : Gender => Number => Str ;
      --            negBefore: Bool} ;
  V2     = TransVerb ; 
      -- = Verbum ** {s2 : Str ; c: Case } ; 
  V3     = DitransVerb ;
      -- = TransVerb ** {s4 : Str; c2: Case} ;
  VS     = SentenceVerb ;
      -- = Verbum ;
  VV     = VerbVerb ; 
      -- = Verbum ;
   

  AdV    = Adverb ;
      -- = {s : Str} ;
  Prep   = Preposition;
      -- = {s : Str ; c: Case } ;
 


  S      = Sentence ; 
      -- = {s : Str} ;
  Slash  = SentenceSlashNounPhrase ; 
      -- = Sentence ** Complement ;
  
  RP     = RelPron ;
      -- = {s : GenNum => Case => Animacy => Str} ;
  RC     = RelClause ;
      -- = RelPron ;

  IP     = IntPron ;
      -- = NounPhrase ;
  Qu     = Question ;
      -- = {s : QuestForm => Str} ;
  Imp    = Imperative ;
      -- = { s: Gender => Number => Str } ;
  Phr    = Utterance ;
      -- = {s : Str} ;
  
  Conj   = Conjunction ;
      -- = {s : Str ; n : Number} ;
  ConjD  = ConjunctionDistr ;
      -- = {s1,s2 : Str ; n : Number} ;

  ListS  = ListSentence ;
      -- = {s1,s2 : Mode => Str} ;
  ListAP = ListAdjPhrase ;
      -- = {s1,s2 : AdjForm => Str ; p : Bool} ;
  ListNP = ListNounPhrase ;
      -- = { s1,s2 : PronForm => Str ; g: Gender ; anim : Animacy ;
      --     n : Number ; p : Person ;  pron : Bool } ;

  PP     = Adverb ;
  Cl     = Clause ;
      -- = {s : Bool => ClForm => Str} ;

}

