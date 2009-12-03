--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarCat of Grammar = 
  NounCat, 
  VerbCat, 
  AdjectiveCat,
  AdverbCat,
  NumeralCat,
  SentenceCat,
  QuestionCat,
  RelativeCat,
  ConjunctionCat,
  PhraseCat,
  TextX - [Temp,Tense],
  IdiomCat,
  StructuralCat,
  TenseCat

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
