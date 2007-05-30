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
  TextX - [Adv],
  IdiomFin,
  StructuralFin
  ** {

flags startcat = Phr ; unlexer = finnish ; lexer = text ;

} ;
