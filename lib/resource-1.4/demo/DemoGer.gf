--# -path=.:alltenses

concrete DemoGer of Demo = 
  NounGer - [AdvCN], 
--  VerbGer, 
  ClauseGer, --
  AdjectiveGer,
  AdverbGer,
  NumeralGer,
--  SentenceGer,
--  QuestionGer,
--  RelativeGer,
--  ConjunctionGer,
--  PhraseGer,
--  TextX - [Tense,TPres,TPast,TFut,TCond],
--  IdiomGer,
  StructuralGer,
  LexiconGer
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
