--# -path=.:alltenses

concrete DemoBul of Demo = 
  NounBul - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbBul, 
  ClauseBul, --
  AdjectiveBul - [SentAP,ComplA2,UseA2,DemoA2],
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
