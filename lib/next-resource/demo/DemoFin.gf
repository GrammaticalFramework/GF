--# -path=.:alltenses

concrete DemoFin of Demo = 
  NounFin,
  ClauseFin,
  AdjectiveFin,
  AdverbFin,
  NumeralFin,
  QuestionFin,
  StructuralFin,
  LexiconFin
  ** {

flags language = fi; unlexer = text ; lexer = text ;

} ;
