--# -path=.:alltenses

concrete DemoFre of Demo = 
  NounFre - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbFre, 
  ClauseFre, --
  AdjectiveFre - [SentAP],
  AdverbFre,
  NumeralFre,
----  SentenceFre,
----  QuestionFre,
----  RelativeFre,
----  ConjunctionFre,
----  PhraseFre,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomFre,
  StructuralFre,
  LexiconFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
