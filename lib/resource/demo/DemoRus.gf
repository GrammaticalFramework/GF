--# -path=.:alltenses

concrete DemoRus of Demo = 
  NounRus,
  ClauseRus,
  AdjectiveRus,
  AdverbRus,
  NumeralRus,
  QuestionRus,
  StructuralRus,
  LexiconRus
  ** {

flags language = ru; unlexer = text ; lexer = text ;

} ;
