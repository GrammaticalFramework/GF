--# -path=.:../abstract:../common:prelude
--# -coding=cp1251

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
  IdiomBul,
  TenseX - [CAdv,IAdv,AdV,SC]
  ** {
  flags coding=cp1251 ;


flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
