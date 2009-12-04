--# -path=.:alltenses

concrete DemoNor of Demo = 
  NounNor,
  ClauseNor,
  AdjectiveNor,
  AdverbNor,
  NumeralNor,
  QuestionNor,
  StructuralNor,
  LexiconNor, TenseX
  ** {

flags language = no; unlexer = text ; lexer = text ;

} ;
