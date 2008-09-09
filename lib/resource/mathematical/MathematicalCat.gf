--# -path=.:present:prelude

concrete MathematicalCat of Mathematical = 
  NounCat - [ComplN2], --- to avoid ambiguity 
--  VerbCat, 
  AdjectiveCat,
  AdverbCat,
  NumeralCat,
--  SentenceCat,
  QuestionCat,
  RelativeCat,
  ConjunctionCat,
  PhraseCat,
  TextX - [Tense,TPres,TPast,TFut,TCond],
  IdiomCat,
  StructuralCat,

  SymbolCat,
  PredicationCat, --  - [predV3,predV2], --- gf bug

  LexiconCat
  ** {

flags startcat = Phr ;

} ;
