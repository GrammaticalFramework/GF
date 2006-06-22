--# -path=.:present:prelude

concrete MathematicalIta of Mathematical = 
  NounIta - [ComplN2], --- to avoid ambiguity 
--  VerbIta, 
  AdjectiveIta,
  AdverbIta,
  NumeralIta,
--  SentenceIta,
  QuestionIta,
  RelativeIta,
  ConjunctionIta,
  PhraseIta,
  TextX - [Tense,TPres,TPast,TFut,TCond],
  IdiomIta,
  StructuralIta,

  SymbolIta,
  PredicationIta, --  - [predV3,predV2], --- gf bug

  LexiconIta
  ** {

flags startcat = Phr ;

} ;
