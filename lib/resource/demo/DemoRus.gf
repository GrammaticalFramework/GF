--# -path=.:alltenses

concrete DemoRus of Demo = 
  NounRus - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbRus, 
  ClauseRus, --
  AdjectiveRus - [SentAP,ComplA2,UseA2,DemoA2],
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
