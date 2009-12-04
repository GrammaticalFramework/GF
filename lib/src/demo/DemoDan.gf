--# -path=.:alltenses

concrete DemoDan of Demo = 
  NounDan,
  ClauseDan,
  AdjectiveDan,
  AdverbDan,
  NumeralDan,
  QuestionDan,
  StructuralDan,
  LexiconDan, TenseX
  ** {

flags language = da; unlexer = text ; lexer = text ;

} ;
