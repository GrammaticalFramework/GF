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
  PhraseTur,
  TextX,
  StructuralTur,
  IdiomTur,
  TenseX
  ** {

flags startcat = Phr ;

} ;
