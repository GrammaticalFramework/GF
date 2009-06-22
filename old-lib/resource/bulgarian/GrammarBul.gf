--# -path=.:../abstract:../common:prelude

concrete GrammarBul of Grammar = 
  NounBul,
  VerbBul,
  AdjectiveBul,
  AdverbBul,
  NumeralBul,
  SentenceBul,
  QuestionBul,
  RelativeBul,
  ConjunctionBul,
  PhraseBul,
  TextBul,
  StructuralBul,
  IdiomBul
  ** {
  flags coding=cp1251 ;


flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
