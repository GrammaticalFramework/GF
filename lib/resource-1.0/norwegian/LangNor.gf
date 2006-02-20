--# -path=.:../scandinavian:../abstract:../common:prelude

concrete LangNor of Lang = 
  NounNor, 
  VerbNor, 
  AdjectiveNor,
  AdverbNor,
  NumeralNor,
  SentenceNor,
  QuestionNor,
  RelativeNor,
  ConjunctionNor,
  PhraseNor,
  TextX,
  IdiomNor,
  StructuralNor,
  LexiconNor
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
