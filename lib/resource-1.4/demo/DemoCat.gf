--# -path=.:alltenses

concrete DemoCat of Demo = 
  NounCat - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbCat, 
  ClauseCat, --
  AdjectiveCat - [SentAP],
  AdverbCat,
  NumeralCat,
----  SentenceCat,
----  QuestionCat,
----  RelativeCat,
----  ConjunctionCat,
----  PhraseCat,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomCat,
  StructuralCat,
  LexiconCat
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
