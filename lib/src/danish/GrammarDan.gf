--# -path=.:../scandinavian:../abstract:../common:prelude

concrete GrammarDan of Grammar = 
  NounDan, 
  VerbDan, 
  AdjectiveDan,
  AdverbDan,
  NumeralDan,
  SentenceDan,
  QuestionDan,
  RelativeDan,
  ConjunctionDan,
  PhraseDan,
  TextX,
  IdiomDan,
  StructuralDan,
  TenseX
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
