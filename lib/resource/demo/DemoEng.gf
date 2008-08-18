--# -path=.:alltenses

concrete DemoEng of Demo = 
  NounEng,
  ClauseEng,
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  QuestionEng,
  StructuralEng,
  LexiconEng
  ** {

flags language = en; unlexer = text ; lexer = text ;

} ;
