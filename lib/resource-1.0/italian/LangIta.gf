--# -path=.:../romance:../abstract:../common:prelude

concrete LangIta of Lang = 
  NounIta, 
  VerbIta, 
  AdjectiveIta,
  AdverbIta,
  NumeralIta,
  SentenceIta,
  QuestionIta,
  RelativeIta,
  ConjunctionIta,
  PhraseIta,
  TextX,
  IdiomIta,
  StructuralIta,
  LexiconIta
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
