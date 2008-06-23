--# -path=.:alltenses

concrete DemoSpa of Demo = 
  NounSpa - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbSpa, 
  ClauseSpa, --
  AdjectiveSpa - [SentAP],
  AdverbSpa,
  NumeralSpa,
----  SentenceSpa,
----  QuestionSpa,
----  RelativeSpa,
----  ConjunctionSpa,
----  PhraseSpa,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomSpa,
  StructuralSpa,
  LexiconSpa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
