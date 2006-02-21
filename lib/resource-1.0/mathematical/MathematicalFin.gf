--# -path=.:../finnish:../abstract:../common:prelude

concrete MathematicalFin of Mathematical = 
  NounFin - [ComplN2], --- to avoid ambiguity 
--  VerbFin, 
--  AdjectiveFin,
--  AdverbFin,
  NumeralFin,
--  SentenceFin,
  QuestionFin,
  RelativeFin,
  ConjunctionFin,
  PhraseFin,
  TextX,
  IdiomFin,
  StructuralFin,

  SymbolFin,
  PredicationFin,

  LexiconFin
  ** {

flags startcat = Phr ;

} ;
