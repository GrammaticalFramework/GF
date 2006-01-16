--# -path=.:../abstract:../common:prelude

concrete LangGer of Lang = 
  NounGer, 
  VerbGer, 
  AdjectiveGer,
  AdverbGer,
--  NumeralGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  ConjunctionGer,
  PhraseGer,
  TensedGer,
  StructuralGer,
  BasicGer
  ** {

flags startcat = Phr ;

} ;
