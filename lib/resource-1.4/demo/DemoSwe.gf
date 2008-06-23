--# -path=.:alltenses

concrete DemoSwe of Demo = 
  NounSwe - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbSwe, 
  ClauseSwe, --
  AdjectiveSwe - [SentAP],
  AdverbSwe,
  NumeralSwe,
----  SentenceSwe,
----  QuestionSwe,
----  RelativeSwe,
----  ConjunctionSwe,
----  PhraseSwe,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomSwe,
  StructuralSwe,
  LexiconSwe
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
