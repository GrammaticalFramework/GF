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
  StructuralEng,
  LexiconEng
  ** {

flags startcat = Phr ;

} ;
