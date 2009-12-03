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
  TextSpa - [Temp,Tense],      -- special punctuation
  IdiomSpa,
  StructuralSpa,
  TenseSpa

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
