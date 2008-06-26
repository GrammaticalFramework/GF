--# -path=.:alltenses

concrete DemoIta of Demo = 
  NounIta - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbIta, 
  ClauseIta, --
  AdjectiveIta - [SentAP],
  AdverbIta,
  NumeralIta,
----  SentenceIta,
  QuestionIta - [QuestVP,QuestSlash],
----  RelativeIta,
----  ConjunctionIta,
----  PhraseIta,
----  TextX,
----  IdiomIta,
  StructuralIta - [everybody_NP,everything_NP,something_NP],
  LexiconIta
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
