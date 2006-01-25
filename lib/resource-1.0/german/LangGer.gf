--# -path=.:../abstract:../common:prelude

concrete LangGer of Lang = 
  NounGer, 
  VerbGer, 
  AdjectiveGer,
  AdverbGer,
  NumeralGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  ConjunctionGer,
  PhraseGer,
  StructuralGer,
  LexiconGer
  ** {

flags startcat = Phr ;

} ;
