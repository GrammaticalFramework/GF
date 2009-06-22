--# -path=.:alltenses

concrete DemoIna of Demo = 
  NounIna - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbIna, 
  ClauseIna, --
  AdjectiveIna - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbIna,
  NumeralIna,
----  SentenceIna,
  QuestionIna - [QuestVP,QuestSlash],
----  RelativeIna,
----  ConjunctionIna,
----  PhraseIna,
----  TextX,
----  IdiomIna,
  StructuralIna - [everybody_NP,everything_NP,something_NP],
  LexiconIna
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
