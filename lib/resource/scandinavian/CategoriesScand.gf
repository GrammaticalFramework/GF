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
      -- = {s : NPForm => Str ; g : Gender ; n : Number} ;
  PN     = {s : Case => Str ; g : NounGender} ;
  Det    = {s : NounGender => Str ; n : Number ; b : SpeciesP} ;
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
  V3A    = DitransAdjVerb ;
  V3V    = DitransVerbVerb ;


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
