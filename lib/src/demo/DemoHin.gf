--# -path=.:alltenses

concrete DemoHin of Demo = 
  NounHin - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbHin, 
  ClauseHin, --
  AdjectiveHin - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbHin,
  NumeralHin,
----  SentenceHin,
  QuestionHin - [QuestVP,QuestSlash],
----  RelativeHin,
----  ConjunctionHin,
----  PhraseHin,
----  TextX,
----  IdiomHin,
  StructuralHin - [everybody_NP,everything_NP,something_NP],
  LexiconHin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
