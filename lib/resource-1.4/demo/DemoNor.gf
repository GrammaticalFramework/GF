--# -path=.:alltenses

concrete DemoNor of Demo = 
  NounNor - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbNor, 
  ClauseNor, --
  AdjectiveNor - [SentAP],
  AdverbNor,
  NumeralNor,
----  SentenceNor,
  QuestionNor - [QuestVP,QuestSlash],
----  RelativeNor,
----  ConjunctionNor,
----  PhraseNor,
----  TextX,
----  IdiomNor,
  StructuralNor - [everybody_NP,everything_NP,something_NP],
  LexiconNor
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
