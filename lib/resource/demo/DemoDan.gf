--# -path=.:alltenses

concrete DemoDan of Demo = 
  NounDan - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbDan, 
  ClauseDan, --
  AdjectiveDan - [SentAP,ComplA2,UseA2,DemoA2],
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
