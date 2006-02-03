--# -path=.:../romance:../abstract:../common:prelude

concrete LangSpa of Lang = 
  NounSpa, 
  VerbSpa, 
  AdjectiveSpa,
  AdverbSpa,
  NumeralSpa,
  SentenceSpa,
  QuestionSpa,
  RelativeSpa,
  ConjunctionSpa,
  PhraseSpa,
  StructuralSpa,
  LexiconSpa
  ** {

flags startcat = Phr ;

} ;
