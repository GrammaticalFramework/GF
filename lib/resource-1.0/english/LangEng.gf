--# -path=.:../abstract:../common:prelude

concrete LangEng of Lang = 
  NounEng, 
  VerbEng, 
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  TensedEng,
  StructuralEng,
  BasicEng
  ** {

flags startcat = Phr ;

} ;
