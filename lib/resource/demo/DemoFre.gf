--# -path=.:alltenses

concrete DemoFre of Demo = 
  NounFre,
  ClauseFre,
  AdjectiveFre,
  AdverbFre,
  NumeralFre,
  QuestionFre,
  StructuralFre,
  LexiconFre
  ** {

flags language = fr; unlexer = text ; lexer = text ;

} ;
