--# -path=.:alltenses

concrete DemoBul of Demo = 
  NounBul - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbBul, 
  ClauseBul, --
  AdjectiveBul - [SentAP],
  AdverbBul,
  NumeralBul,
----  SentenceBul,
----  QuestionBul,
----  RelativeBul,
----  ConjunctionBul,
----  PhraseBul,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomBul,
  StructuralBul,
  LexiconBul
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
