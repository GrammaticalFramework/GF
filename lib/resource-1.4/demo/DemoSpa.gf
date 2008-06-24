--# -path=.:alltenses

concrete DemoSpa of Demo = 
  NounSpa - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbSpa, 
  ClauseSpa, --
  AdjectiveSpa - [SentAP],
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
