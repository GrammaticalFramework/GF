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
  TextSpa,      -- special punctuation
  IdiomSpa,
  StructuralSpa,
  LexiconSpa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
