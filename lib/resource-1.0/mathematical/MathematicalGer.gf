--# -path=.:../german:../abstract:../common:prelude

concrete MathematicalGer of Mathematical = 
  NounGer - [ComplN2], --- to avoid ambiguity 
--  VerbGer, 
--  AdjectiveGer,
--  AdverbGer,
  NumeralGer,
--  SentenceGer,
  QuestionGer,
  RelativeGer,
  ConjunctionGer,
  PhraseGer,
  StructuralGer,

  SymbolGer,
  PredicationGer,

  LexiconGer
  ** {

flags startcat = Phr ;

} ;
