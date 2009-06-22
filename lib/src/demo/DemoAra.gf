--# -path=.:alltenses

concrete DemoAra of Demo = 
  NounAra - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbAra, 
  ClauseAra, --
  AdjectiveAra - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbAra,
  NumeralAra,
----  SentenceAra,
  QuestionAra - [QuestVP,QuestSlash],
----  RelativeAra,
----  ConjunctionAra,
----  PhraseAra,
----  TextX,
----  IdiomAra,
  StructuralAra - [everybody_NP,everything_NP,something_NP],
  LexiconAra
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
