--# -path=.:alltenses

concrete DemoIta of Demo = 
  NounIta,
  ClauseIta,
  AdjectiveIta,
  AdverbIta,
  NumeralIta,
  QuestionIta,
  StructuralIta,
  LexiconIta
  ** {

flags language = it; unlexer = text ; lexer = text ;

} ;
