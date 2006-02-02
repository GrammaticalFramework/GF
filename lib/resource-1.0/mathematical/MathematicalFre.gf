--# -path=.:../french:../romance:../abstract:../common:prelude

concrete MathematicalFre of Mathematical = 
  NounFre - [ComplN2], --- to avoid ambiguity 
--  VerbFre, 
--  AdjectiveFre,
--  AdverbFre,
  NumeralFre,
--  SentenceFre,
  QuestionFre,
  RelativeFre,
  ConjunctionFre,
  PhraseFre,
  StructuralFre,

  SymbolFre,
  PredicationFre - [predV3], ---- gf bug

  LexiconFre
  ** {

flags startcat = Phr ;

} ;
