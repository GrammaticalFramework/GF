--# -path=.:../abstract:../common:prelude

concrete GrammarTur of Grammar =
  NounTur,
  VerbTur,
  AdjectiveTur,
  AdverbTur,
  NumeralTur,
  SentenceTur,
  QuestionTur,
  RelativeTur,
  ConjunctionTur,
  TextX,
  StructuralTur,
  PhraseTur,
  IdiomTur,
  TenseX
  ** {

  flags startcat = Phr ;

} ;
