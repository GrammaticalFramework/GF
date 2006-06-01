--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarSpa of Grammar = 
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
  StructuralSpa

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
