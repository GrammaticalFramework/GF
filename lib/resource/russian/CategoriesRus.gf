--# -path=.:../abstract:../../prelude

--1 The Top-Level Russian Resource Grammar: Combination Rules
--
-- Aarne Ranta, Janna Khegai 2003 -- 2005
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
  A      = Adjective ;
      -- = {s : AdjForm => Str} ;
  A2   = AdjCompl ;
      -- = Adjective ** Complement ;
  ADeg = AdjDegr ;
      -- = {s : Degree => AdjForm => Str} ;
  AP     = AdjPhrase ; 
      -- = Adjective ** {p : IsPostfixAdj} ; 

  Det    = Determiner ;
      -- = Adjective ** {n: Number; g: PronGen; c: Case} ; 
  NDet   = Adjective ** {g: PronGen; c: Case} ; 
      -- "Det" without "Number" field

  N2     = Function ;  
      -- = CommNounPhrase ** Complement ;
  N3     = Function ** {s3 : Str; c2: Case} ; 
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
      -- = Verbum ** Complement ; 
  V3     = DitransVerb ;
      -- = TransVerb ** {s4 : Str; c2: Case} ;
  VS     = SentenceVerb ;
      -- = Verbum ;
  VV     = VerbVerb ; 
      -- = Verbum ;
   
  VCl    = {s  : Bool => Anteriority => Str} ;
     -- infinitive verb phrase (in other languages very similar to VPI,
     -- but without Bool=>Anteriority)
  VPI    = VerbPhraseInf ;
     -- {s  : Str; a: Aspect; w:Voice; s2 : Str ; 
     --  s3 : Gender => Number => Str ; negBefore: Bool} ;
     -- almost the same as VP, but VF is fixed to the infinitive form
     -- and the tense field is supressed

  Adv    = Adverb ;    -- sentence adverb e.g. "now", "in the house"
      -- = {s : Str} ;
  AdV    = Adverb ;
  AdA    = Adverb ;    -- ad-adjective           e.g. "very"
  AdC    = Adverb ;    -- conjoining adverb      e.g. "therefore", "otherwise"
  Prep   = Preposition;
      -- = {s : Str ; c: Case } ;
  PP     = Adverb ;

  Cl     = Clause ; -- clause (variable tense) e.g. "John walks"/"John walked"
      -- = {s : Bool => ClForm => Str} ;
  S      = Sentence ; 
      -- = {s : Str} ;
  Slash  = SentenceSlashNounPhrase ; 
      -- sentence without NP, e.g. "John waits for (...)"
      -- = Sentence ** Complement ;
  
  RP     = RelPron ;
      -- = {s :                   GenNum => Case => Animacy => Str} ;
  RS     = RelPron ;          
  RCl    = RelClause ;
      -- = {s :  Bool => ClForm => GenNum => Case => Animacy => Str} ;

  IP     = IntPron ;
      -- = NounPhrase ;
  IDet   = Determiner ;
      -- = Adjective ** {n: Number; g: PronGen; c: Case} ; 

  IAdv   = Adverb ;   
      -- = {s : Str} ;

  QS     = Question ;     -- question w. fixed tense
      -- = {s :                 QuestForm => Str} ;
  QCl    = {s :Bool => ClForm => QuestForm => Str};  

  Imp    = Imperative ;
      -- = { s: Gender => Number => Str } ;
  
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
  ListAdv= {s1 : Str ; s2 : Str} ;

  Phr    = Utterance ;
      -- = {s : Str} ;
  Text   = {s : Str} ;

---- next

  VQ     = Verbum ; 
      -- = {s : VerbForm => Str ; asp : Aspect } ;
  VA     = Verbum ; 
  V0     = Verbum ; 
  V2A    = TransVerb ;   
      -- = Verbum ** Complement ; 
  V2V    = TransVerb ;   
  V2S    = TransVerb ;   
  V2Q    = TransVerb ; 

  AS     = Adverb ;   
      -- = {s : Str} ;
  A2S    = Adverb ** Complement;       
  AV     = Adjective ;
      -- = {s : AdjForm => Str} ;      
  A2V    = AdjCompl ;
      -- = Adjective ** Complement ;
 
-- NB: it is difficult to play the sonata 
-- vs. it (the sonata) is difficult to play

-- also : John is easy (for you) to please vs. John is eager to please


-- similar implementation in all the languages, s-field is dummy:

  TP     = {s : Str ; b : Bool ; t : ClTense ; a : Anteriority} ; -- combination of the three below
  Tense  = {s : Str ; t : ClTense} ;                                 
  Ant    = {s : Str ; a : Anteriority} ; --For time agreement:
  Pol    = {s : Str ; p : Bool} ;  --Positive or negative statement
  Subj   = {s : Str} ;
}

