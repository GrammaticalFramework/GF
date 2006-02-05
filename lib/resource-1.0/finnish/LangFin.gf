--# -path=.:../abstract:../common:prelude

concrete LangFin of Lang = 
  NounFin, 
  VerbFin, 
--  AdjectiveFin,
  AdverbFin,
--  NumeralFin,
  SentenceFin,
--  QuestionFin,
--  RelativeFin,
  ConjunctionFin,
  PhraseFin,
  StructuralFin,
  LexiconFin
  ** {

flags startcat = Phr ;

} ;
