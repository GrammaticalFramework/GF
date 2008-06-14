--# -path=.:alltenses

concrete DemoFre of Demo = 
  NounFre - [AdvCN], 
--  VerbFre, 
  ClauseFre, --
  AdjectiveFre,
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
