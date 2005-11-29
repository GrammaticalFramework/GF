--# -path=.:prelude

concrete TestEng of Test = 
  NounEng, 
  VerbEng, 
  AdjectiveEng,
  -- NumeralEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  UntensedEng,
  -- TensedEng,
  LexEng 
  ** {} ;
