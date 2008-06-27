--# -path=.:alltenses

concrete DemoNor of Demo = 
  NounNor - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbNor, 
  ClauseNor, --
  AdjectiveNor - [SentAP,ComplA2,UseA2,DemoA2],
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
