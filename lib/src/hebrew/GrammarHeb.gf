--# -path=.:../abstract:../common:prelude

concrete GrammarHeb of Grammar = 
  NounHeb,
  VerbHeb,
  AdjectiveHeb,
  AdverbHeb,
--  NumeralHeb,
  SentenceHeb,
--  QuestionHeb,
--  IdiomHeb,
--  RelativeHeb,
--  ConjunctionHeb, 
  PhraseHeb,
--  TextHeb,
  StructuralHeb,
  TenseHeb 
  ** {
  flags coding=utf8 ;


flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
