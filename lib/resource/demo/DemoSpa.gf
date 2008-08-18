--# -path=.:alltenses

concrete DemoSpa of Demo = 
  NounSpa,
  ClauseSpa,
  AdjectiveSpa,
  AdverbSpa,
  NumeralSpa,
  QuestionSpa,
  StructuralSpa,
  LexiconSpa
  ** {

flags language = es; unlexer = text ; lexer = text ;

} ;
