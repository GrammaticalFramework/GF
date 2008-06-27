--# -path=.:alltenses

concrete DemoIta of Demo = 
  NounIta - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbIta, 
  ClauseIta, --
  AdjectiveIta - [SentAP,ComplA2,UseA2,DemoA2],
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
