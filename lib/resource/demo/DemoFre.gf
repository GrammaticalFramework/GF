--# -path=.:alltenses

concrete DemoFre of Demo = 
  NounFre - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbFre, 
  ClauseFre, --
  AdjectiveFre - [SentAP],
  AdverbFre,
  NumeralFre,
----  SentenceFre,
  QuestionFre - [QuestVP,QuestSlash],
----  RelativeFre,
----  ConjunctionFre,
----  PhraseFre,
----  TextX,
----  IdiomFre,
  StructuralFre - [everybody_NP,everything_NP,something_NP],
  LexiconFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
