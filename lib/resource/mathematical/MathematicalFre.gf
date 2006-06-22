--# -path=.:present:prelude

concrete MathematicalFre of Mathematical = 
  NounFre - [ComplN2], --- to avoid ambiguity 
--  VerbFre, 
  AdjectiveFre,
  AdverbFre,
  NumeralFre,
--  SentenceFre,
  QuestionFre,
  RelativeFre,
  ConjunctionFre,
  PhraseFre,
  TextX - [Tense,TPres,TPast,TFut,TCond],
  IdiomFre,
  StructuralFre,
  
  SymbolFre,
  PredicationFre - [predV3], ---- gf bug

  LexiconFre
  ** {

flags startcat = Phr ;

} ;
