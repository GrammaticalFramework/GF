--# -path=.:alltenses

concrete DemoGer of Demo = 
  NounGer - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbGer, 
  ClauseGer, --
  AdjectiveGer - [SentAP],
  AdverbGer,
  NumeralGer,
--  SentenceGer,
  QuestionGer - [QuestVP,QuestSlash],
--  RelativeGer,
--  ConjunctionGer,
--  PhraseGer,
--  TextX - [Tense,TPres,TPast,TFut,TCond],
--  IdiomGer,
  StructuralGer,
  LexiconGer
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
