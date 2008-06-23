--# -path=.:alltenses

concrete DemoIta of Demo = 
  NounIta - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbIta, 
  ClauseIta, --
  AdjectiveIta - [SentAP],
  AdverbIta,
  NumeralIta,
----  SentenceIta,
----  QuestionIta,
----  RelativeIta,
----  ConjunctionIta,
----  PhraseIta,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomIta,
  StructuralIta,
  LexiconIta
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
