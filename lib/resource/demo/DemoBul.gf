--# -path=.:alltenses

concrete DemoBul of Demo = 
  NounBul,
  ClauseBul,
  AdjectiveBul,
  AdverbBul,
  NumeralBul,
  QuestionBul,
  StructuralBul,
  LexiconBul
  ** {

flags language = bg; unlexer = text ; lexer = text ;

} ;
