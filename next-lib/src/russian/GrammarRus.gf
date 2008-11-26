--# -path=.:../abstract:../common:../../prelude

concrete GrammarRus of Grammar = 
  NounRus, 
  VerbRus, 
  AdjectiveRus,
  AdverbRus,
  NumeralRus,
  SentenceRus,
  QuestionRus,
  RelativeRus,
  ConjunctionRus,
  PhraseRus,
  TextX,
  StructuralRus,
  IdiomRus
   ** { flags  startcat = Phr ; unlexer = text ; lexer = text ; coding=utf8 ;} ;
