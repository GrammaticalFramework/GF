--# -path=.:alltenses

concrete DemoGer of Demo = 
  NounGer,
  ClauseGer,
  AdjectiveGer,
  AdverbGer,
  NumeralGer,
  QuestionGer,
  StructuralGer,
  LexiconGer
  ** {

flags language = de; unlexer = text ; lexer = text ;

} ;
