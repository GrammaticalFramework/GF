--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarFre of Grammar = 
  NounFre, 
  VerbFre, 
  AdjectiveFre,
  AdverbFre,
  NumeralFre,
  SentenceFre,
  QuestionFre,
  RelativeFre,
  ConjunctionFre,
  PhraseFre,
  TextX - [Temp,Tense],
  IdiomFre,
  StructuralFre,
  TenseFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
