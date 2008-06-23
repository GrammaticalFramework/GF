--# -path=.:alltenses

concrete DemoNor of Demo = 
  NounNor - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbNor, 
  ClauseNor, --
  AdjectiveNor - [SentAP],
  AdverbNor,
  NumeralNor,
----  SentenceNor,
----  QuestionNor,
----  RelativeNor,
----  ConjunctionNor,
----  PhraseNor,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomNor,
  StructuralNor,
  LexiconNor
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
