--# -path=.:alltenses

concrete DemoFin of Demo = 
  NounFin - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbFin, 
  ClauseFin, --
  AdjectiveFin - [SentAP],
  AdverbFin,
  NumeralFin,
----  SentenceFin,
  QuestionFin - [QuestVP,QuestSlash],
----  RelativeFin,
----  ConjunctionFin,
----  PhraseFin,
----  TextX,
----  IdiomFin,
  StructuralFin - [everybody_NP,everything_NP,something_NP],
  LexiconFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
