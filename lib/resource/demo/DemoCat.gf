--# -path=.:alltenses

concrete DemoCat of Demo = 
  NounCat - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbCat, 
  ClauseCat, --
  AdjectiveCat - [SentAP],
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
