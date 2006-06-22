--# -path=.:../abstract:../common:prelude

concrete TestEng of Test = 
  NounEng, 
  VerbEng, 
  AdjectiveEng,
  AdverbEng,
  -- NumeralEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  UntensedEng,
  -- TensedEng,
  LexEng 
  ** {

flags startcat = Phr ;

} ;
