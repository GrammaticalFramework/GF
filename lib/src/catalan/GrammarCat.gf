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
  TextX - [SC,Temp,Tense,Pol,PPos,PNeg],
  IdiomCat,
  StructuralCat,
  TenseCat

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
