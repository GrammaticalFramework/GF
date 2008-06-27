--# -path=.:alltenses

concrete DemoCat of Demo = 
  NounCat - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbCat, 
  ClauseCat, --
  AdjectiveCat - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbCat,
  NumeralCat,
----  SentenceCat,
  QuestionCat - [QuestVP,QuestSlash],
----  RelativeCat,
----  ConjunctionCat,
----  PhraseCat,
----  TextX,
----  IdiomCat,
  StructuralCat - [everybody_NP,everything_NP,something_NP],
  LexiconCat
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
