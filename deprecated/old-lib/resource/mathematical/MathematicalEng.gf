--# -path=.:present:prelude

concrete MathematicalEng of Mathematical = 
  NounEng - [ComplN2], --- to avoid ambiguity 
--  VerbEng, 
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
--  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  StructuralEng,
  TextX,
  IdiomEng,

  SymbolEng,
  PredicationEng,

  LexiconEng
  ** {

flags startcat = Phr ;

} ;
