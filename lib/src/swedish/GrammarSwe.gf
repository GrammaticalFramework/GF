--# -path=.:../scandinavian:../abstract:../common:prelude

concrete GrammarSwe of Grammar = 
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
  TenseX
  ** {

flags startcat = Phr ;  unlexer = text ; lexer = text ;

} ;
