--# -path=.:../scandinavian:../abstract:../common:prelude

concrete TestSwe of Test = 
  NounSwe, 
  VerbSwe, 
  AdjectiveSwe,
  AdverbSwe,
--  -- NumeralSwe,
  SentenceSwe,
  QuestionSwe,
--  RelativeSwe,
  ConjunctionSwe,
  PhraseSwe,
  UntensedSwe,
--  -- TensedSwe,
  LexSwe 
  ** {

flags startcat = Phr ;

} ;
