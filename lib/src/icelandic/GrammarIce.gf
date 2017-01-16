--# -path=.:../abstract:../common:prelude

concrete GrammarIce of Grammar = 
  NounIce, 
  VerbIce, 
  AdjectiveIce,
  AdverbIce,
  NumeralIce,
  SentenceIce,
  QuestionIce,
  RelativeIce,
  ConjunctionIce,
  PhraseIce,
  TextX,
  StructuralIce,
  IdiomIce,
  TenseX
  ** open ResIce, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
