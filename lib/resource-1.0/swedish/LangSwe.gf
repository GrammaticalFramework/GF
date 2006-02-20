--# -path=.:../scandinavian:../abstract:../common:prelude

concrete LangSwe of Lang = 
  NounSwe, 
  VerbSwe, 
  AdjectiveSwe,
  AdverbSwe,
  NumeralSwe,
  SentenceSwe,
  QuestionSwe,
  RelativeSwe,
  ConjunctionSwe,
  PhraseSwe,
  TextX,
  IdiomSwe,
  StructuralSwe,
  LexiconSwe
  ** {

flags startcat = Phr ;  unlexer = text ; lexer = text ;

} ;
