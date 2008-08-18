--# -path=.:alltenses

concrete DemoCat of Demo = 
  NounCat,
  ClauseCat,
  AdjectiveCat,
  AdverbCat,
  NumeralCat,
  QuestionCat,
  StructuralCat,
  LexiconCat
  ** {

flags language = ca; unlexer = text ; lexer = text ;

} ;
