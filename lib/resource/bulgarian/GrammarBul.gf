--# -path=.:../abstract:../common:prelude

concrete GrammarBul of Grammar = 
  NounBul,
  VerbBul,
  AdjectiveBul,
  NumeralBul,
  SentenceBul,
  QuestionBul,
  PhraseBul,
  TextX,
  StructuralBul
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
