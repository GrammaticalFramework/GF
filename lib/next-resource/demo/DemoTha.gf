--# -path=.:alltenses

concrete DemoTha of Demo = 
  NounTha - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbTha, 
  ClauseTha, --
  AdjectiveTha - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbTha,
  NumeralTha,
----  SentenceTha,
  QuestionTha - [QuestVP,QuestSlash],
----  RelativeTha,
----  ConjunctionTha,
----  PhraseTha,
----  TextX,
----  IdiomTha,
  StructuralTha - [everybody_NP,everything_NP,something_NP],
  LexiconTha
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
