--# -path=.:alltenses

concrete DemoFin of Demo = 
  NounFin - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbFin, 
  ClauseFin, --
  AdjectiveFin - [SentAP,ComplA2,UseA2,DemoA2],
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
