--# -path=.:alltenses

concrete DemoBul of Demo = 
  NounBul - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbBul, 
  ClauseBul, --
  AdjectiveBul - [SentAP],
  AdverbBul,
  NumeralBul,
----  SentenceBul,
  QuestionBul - [QuestVP,QuestSlash],
----  RelativeBul,
----  ConjunctionBul,
----  PhraseBul,
----  TextX,
----  IdiomBul,
  StructuralBul - [everybody_NP,everything_NP,something_NP],
  LexiconBul
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
