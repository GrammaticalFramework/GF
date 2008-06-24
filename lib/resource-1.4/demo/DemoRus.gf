--# -path=.:alltenses

concrete DemoRus of Demo = 
  NounRus - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbRus, 
  ClauseRus, --
  AdjectiveRus - [SentAP],
  AdverbRus,
  NumeralRus,
----  SentenceRus,
  QuestionRus - [QuestVP,QuestSlash],
----  RelativeRus,
----  ConjunctionRus,
----  PhraseRus,
----  TextX,
----  IdiomRus,
  StructuralRus - [everybody_NP,everything_NP,something_NP],
  LexiconRus
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
