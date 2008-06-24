--# -path=.:alltenses

concrete DemoSwe of Demo = 
  NounSwe - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbSwe, 
  ClauseSwe, --
  AdjectiveSwe - [SentAP],
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
