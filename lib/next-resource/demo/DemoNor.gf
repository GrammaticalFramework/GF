--# -path=.:alltenses

concrete DemoNor of Demo = 
  NounNor,
  ClauseNor,
  AdjectiveNor,
  AdverbNor,
  NumeralNor,
  QuestionNor,
  StructuralNor,
  LexiconNor
  ** {

flags language = no; unlexer = text ; lexer = text ;

} ;
