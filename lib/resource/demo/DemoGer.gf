--# -path=.:alltenses

concrete DemoGer of Demo = 
  NounGer - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbGer, 
  ClauseGer, --
  AdjectiveGer - [SentAP],
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
