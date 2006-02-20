--# -path=.:../romance:../abstract:../common:prelude

concrete LangFre of Lang = 
  NounFre, 
  VerbFre, 
  AdjectiveFre,
  AdverbFre,
  NumeralFre,
  SentenceFre,
  QuestionFre,
  RelativeFre,
  ConjunctionFre,
  PhraseFre,
  TextX,
  IdiomFre,
  StructuralFre,
  LexiconFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
