--# -path=.:alltenses

concrete DemoGer of Demo = 
  NounGer - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbGer, 
  ClauseGer, --
  AdjectiveGer - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbGer,
  NumeralGer,
----  SentenceGer,
  QuestionGer - [QuestVP,QuestSlash],
----  RelativeGer,
----  ConjunctionGer,
----  PhraseGer,
----  TextX,
----  IdiomGer,
  StructuralGer - [everybody_NP,everything_NP,something_NP],
  LexiconGer
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
