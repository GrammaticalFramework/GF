--# -path=.:alltenses

concrete DemoSwe of Demo = 
  NounSwe,
  ClauseSwe,
  AdjectiveSwe,
  AdverbSwe,
  NumeralSwe,
  QuestionSwe,
  StructuralSwe,
  LexiconSwe, TenseX
  ** {

flags language = sv; unlexer = text ; lexer = text ;

} ;
