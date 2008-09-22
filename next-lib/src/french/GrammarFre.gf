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
  TextX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond],
  IdiomFre,
  StructuralFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
