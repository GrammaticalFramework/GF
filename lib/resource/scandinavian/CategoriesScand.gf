incomplete concrete CategoriesScand of Categories = 
  open Prelude, SyntaxScand in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lincat 
  CN     = {s : Number => SpeciesP => Case => Str ; g : NounGender ; 
            p : IsComplexCN} ;
  N      = CommNoun ;
      -- = {s : Number => Species => Case => Str ; g : NounGender} ;
  NP     = NounPhrase ;
      -- = {s : NPForm => Str ; g : Gender ; n : Number ; p : Person} ;
  PN     = {s : Case => Str ; g : NounGender} ;
  Det    = {s : NounGender => Str ; n : Number ; b : SpeciesP} ;
  NDet   = {s : NounGender => Str ;              b : SpeciesP} ;
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
  AS     = Adjective ; --- "more difficult for him to come than..."
  A2S    = Adjective ** {s2 : Preposition} ;
  AV     = Adjective ;
  A2V    = Adjective ** {s2 : Preposition} ;

  V      = Verb ;
      -- = {s : VerbForm => Str ; s1 : Str} ;
  VP     = {s  : SForm => Str ; s2 : Bool => Str ; 
            s3 : SForm => Gender => Number => Person => Str} ;
  VPI    = {s  : VIForm => Gender => Number => Person => Str} ;
  V2     = TransVerb ; 
      -- = Verb ** {s2 : Preposition} ;
  V3     = TransVerb ** {s3 : Preposition} ;

  VS     = Verb ;
  VQ     = Verb ;
  VV     = Verb ** {s3 : Str} ;
  VA     = Verb ;

  V2S    = TransVerb ;
  V2Q    = TransVerb ;
  V2V    = DitransVerbVerb ;
  V2A    = DitransAdjVerb ;
  V0     = Verb ;

  TP     = {s : Str ; b : Bool ; t : Tense ; a : Anteriority} ; --- the Str field is dummy
  Tense  = {s : Str ; t : Tense} ;
  Ant    = {s : Str ; a : Anteriority} ;
  

  Adv    = Adverb ; 
      -- = {s : Str} ;
  AdV    = Adverb ; 
  AdA    = Adverb ; 
  AdC    = Adverb ; 
  PP     = Adverb ;

  S      = Sentence ;
      -- = {s :                  Order => Str} ;
  Cl     = Clause ;
      -- = {s : Bool => SForm => Order => Str} ;
  Slash  = Clause ** {s2 : Preposition} ;
  RP     = {s : RelCase => GenNum => Str ; g : RelGender} ;
  RS     = {s :                  GenNum => Person => Str} ;
  RCl    = {s : Bool => SForm => GenNum => Person => Str} ;
  IP     = NounPhrase ;
  IDet   = {s : NounGender => Str ; n : Number ; b : SpeciesP} ;
  QS     = {s :                  QuestForm => Str} ;
  QCl    = {s : Bool => SForm => QuestForm => Str} ;
  Imp    = {s : Number => Str} ;

  Phr    = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1,s2 : Order => Str} ; 
  ListAP = {s1,s2 : AdjFormPos => Case => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; g : Gender ; n : Number ; p : Person} ;
  ListAdv = {s1,s2 : Str} ; 

}
