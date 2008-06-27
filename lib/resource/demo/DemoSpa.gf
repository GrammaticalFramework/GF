--# -path=.:alltenses

concrete DemoSpa of Demo = 
  NounSpa - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbSpa, 
  ClauseSpa, --
  AdjectiveSpa - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbSpa,
  NumeralSpa,
----  SentenceSpa,
  QuestionSpa - [QuestVP,QuestSlash],
----  RelativeSpa,
----  ConjunctionSpa,
----  PhraseSpa,
----  TextX,
----  IdiomSpa,
  StructuralSpa - [everybody_NP,everything_NP,something_NP],
  LexiconSpa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
