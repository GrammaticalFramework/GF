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
  TextX,
  StructuralEng,
  IdiomEng,
  LexiconEng
  ** {

flags startcat = Phr ;

} ;
