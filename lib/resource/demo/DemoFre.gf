--# -path=.:alltenses

concrete DemoFre of Demo = 
  NounFre - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbFre, 
  ClauseFre, --
  AdjectiveFre - [SentAP,ComplA2,UseA2,DemoA2],
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
