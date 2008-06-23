--# -path=.:alltenses

concrete DemoDan of Demo = 
  NounDan - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP],
--  VerbDan, 
  ClauseDan, --
  AdjectiveDan - [SentAP],
  AdverbDan,
  NumeralDan,
----  SentenceDan,
----  QuestionDan,
----  RelativeDan,
----  ConjunctionDan,
----  PhraseDan,
----  TextX - [Tense,TPres,TPast,TFut,TCond],
----  IdiomDan,
  StructuralDan,
  LexiconDan
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
