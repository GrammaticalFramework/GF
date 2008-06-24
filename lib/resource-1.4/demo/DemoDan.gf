--# -path=.:alltenses

concrete DemoDan of Demo = 
  NounDan - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbDan, 
  ClauseDan, --
  AdjectiveDan - [SentAP],
  AdverbDan,
  NumeralDan,
----  SentenceDan,
  QuestionDan - [QuestVP,QuestSlash],
----  RelativeDan,
----  ConjunctionDan,
----  PhraseDan,
----  TextX,
----  IdiomDan,
  StructuralDan - [everybody_NP,everything_NP,something_NP],
  LexiconDan
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
