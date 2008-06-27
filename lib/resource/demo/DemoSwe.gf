--# -path=.:alltenses

concrete DemoSwe of Demo = 
  NounSwe - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbSwe, 
  ClauseSwe, --
  AdjectiveSwe - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbSwe,
  NumeralSwe,
----  SentenceSwe,
  QuestionSwe - [QuestVP,QuestSlash],
----  RelativeSwe,
----  ConjunctionSwe,
----  PhraseSwe,
----  TextX,
----  IdiomSwe,
  StructuralSwe - [everybody_NP,everything_NP,something_NP],
  LexiconSwe
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
