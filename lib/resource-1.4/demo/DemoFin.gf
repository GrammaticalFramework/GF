--# -path=.:alltenses

concrete DemoFin of Demo = 
  NounFin - [AdvCN], 
--  VerbFin, 
  ClauseFin, --
  AdjectiveFin,
  AdverbFin,
  NumeralFin,
----  SentenceFin,
----  QuestionFin,
----  RelativeFin,
----  ConjunctionFin,
----  PhraseFin,
----  TextX,
----  IdiomFin,
  StructuralFin,
  LexiconFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
