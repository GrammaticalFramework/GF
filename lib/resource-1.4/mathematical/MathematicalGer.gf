--# -path=.:present:prelude

concrete MathematicalGer of Mathematical = 
  NounGer - [ComplN2], --- to avoid ambiguity 
--  VerbGer, 
  AdjectiveGer,
  AdverbGer,
  NumeralGer,
--  SentenceGer,
  QuestionGer,
  RelativeGer,
  ConjunctionGer,
  PhraseGer,
  TextX - [Tense,TPres],
  IdiomGer,
  StructuralGer,

  SymbolGer,
  PredicationGer,

  LexiconGer
  ** {

flags startcat = Phr ;

} ;
