--# -path=.:../abstract:../common:prelude

concrete LangFin of Lang = 
  NounFin, 
  VerbFin, 
  AdjectiveFin,
  AdverbFin,
  NumeralFin,
  SentenceFin,
  QuestionFin,
  RelativeFin,
  ConjunctionFin,
  PhraseFin,
  TextX,
  IdiomFin,
  StructuralFin,
  LexiconFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
