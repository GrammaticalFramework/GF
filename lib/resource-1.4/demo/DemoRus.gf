--# -path=.:alltenses

concrete DemoRus of Demo = 
  NounRus - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbRus, 
  ClauseRus, --
  AdjectiveRus - [SentAP],
  AdverbRus,
  NumeralRus,
----  SentenceRus,
----  QuestionRus,
----  RelativeRus,
----  ConjunctionRus,
----  PhraseRus,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomRus,
  StructuralRus,
  LexiconRus
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ; coding = utf8 ;

} ;
