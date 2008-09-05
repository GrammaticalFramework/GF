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
  TextX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond],
  IdiomCat,
  StructuralCat

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
