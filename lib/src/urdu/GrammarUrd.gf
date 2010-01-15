--# -path=.:../abstract:../common:../prelude

 concrete GrammarUrd of Grammar = 
  NounUrd, 
  VerbUrd, 
  AdjectiveUrd,
  AdverbUrd,
  NumeralUrd,
  SentenceUrd,
  QuestionUrd,
  RelativeUrd,
  ConjunctionUrd,
  PhraseUrd,
  TextX,
  StructuralUrd,
  TenseX,
  IdiomUrd
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


