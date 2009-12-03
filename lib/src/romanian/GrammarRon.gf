--# -path=.:../abstract:../common:../prelude

concrete GrammarRon of Grammar = 
  NounRon, 
  VerbRon, 
  AdjectiveRon,
  AdverbRon,
  NumeralRon,
  SentenceRon,
  IdiomRon,
  QuestionRon,
  RelativeRon,
  ConjunctionRon,
  PhraseRon,
  TextX - [CAdv,Temp,Tense],
  Prelude, MorphoRon, Coordination,
  StructuralRon,
  TenseRon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
