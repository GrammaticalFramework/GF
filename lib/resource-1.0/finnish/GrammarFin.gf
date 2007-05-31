--# -path=.:../abstract:../common:prelude

concrete GrammarFin of Grammar = 
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
  StructuralFin
  ** {

flags startcat = Phr ; unlexer = finnish ; lexer = text ;

} ;
