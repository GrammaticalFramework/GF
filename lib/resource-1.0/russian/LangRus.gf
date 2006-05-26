--# -path=.:../abstract:../common:../../prelude

concrete LangRus of Lang = 
  NounRus, 
  VerbRus, 
  AdjectiveRus,
  AdverbRus,
  NumeralRus,
  SentenceRus,
  QuestionRus,
  RelativeRus,
  ConjunctionRus,
  PhraseRus,
  TextX,
  StructuralRus,
  IdiomRus,
  LexiconRus ** { flags  startcat = Phr ; unlexer = text ; lexer = text ;} ;
