--# -path=.:../abstract:../common:prelude

concrete LangGer of Lang = 
  NounGer, 
  VerbGer, 
  AdjectiveGer,
  AdverbGer,
  NumeralGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  ConjunctionGer,
  PhraseGer,
  TextX,
  IdiomGer,
  StructuralGer,
  LexiconGer
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
