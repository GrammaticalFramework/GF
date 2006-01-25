--# -path=.:../romance:../abstract:../common:prelude

concrete TestFre of Test = 
  NounFre, 
  VerbFre, 
  AdjectiveFre,
  AdverbFre,
--  -- NumeralFre,
  SentenceFre,
  QuestionFre,
  RelativeFre,
  ConjunctionFre,
  PhraseFre,
  UntensedFre,
--  -- TensedFre,
  LexFre 
  ** {

flags startcat = Phr ;

} ;
