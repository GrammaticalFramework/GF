--# -path=.:../french:../romance:../abstract:../common:prelude

concrete MinimalFre of Minimal = 
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
  StructuralFre,
  IdiomFre,
  LexiconFre
  ** {

flags startcat = Phr ; -- unlexer = text ; lexer = text ;

} ;
