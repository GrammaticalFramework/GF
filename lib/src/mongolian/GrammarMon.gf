--# -path=.:../abstract:../common:../prelude

concrete GrammarMon of Grammar = 
  NounMon, 
  VerbMon, 
  AdjectiveMon,
  AdverbMon,
  NumeralMon,
  SentenceMon,
  QuestionMon,
  RelativeMon,
  ConjunctionMon,
  PhraseMon,
  TextX - [CAdv,Tense,Temp],
  StructuralMon,
  IdiomMon, 
  TenseMon,
  NumeralTransferMon
  ** { flags  startcat = Phr ; unlexer = text ; lexer = text ; coding=utf8 ; } ;
