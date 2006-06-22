--# -path=.:../abstract:../common:prelude

concrete TestGer of Test = 
  NounGer, 
  VerbGer, 
  AdjectiveGer,
  AdverbGer,
  -- NumeralGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  ConjunctionGer,
  PhraseGer,
  UntensedGer,
  -- TensedGer,
  LexGer 
  ** {
  flags startcat = Phr ;
} ;
