--# -path=.:../scandinavian:../abstract:../common:prelude

concrete LangDan of Lang = 
  NounDan, 
  VerbDan, 
  AdjectiveDan,
  AdverbDan,
  NumeralDan,
  SentenceDan,
  QuestionDan,
  RelativeDan,
  ConjunctionDan,
  PhraseDan,
  TextX,
  IdiomDan,
  StructuralDan,
  LexiconDan
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
