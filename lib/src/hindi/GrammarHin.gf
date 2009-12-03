--# -path=.:../abstract:../common:prelude

concrete GrammarHin of Grammar = 
  NounHin, 
  VerbHin, 
  AdjectiveHin,
  AdverbHin,
  NumeralHin,
  SentenceHin,
  QuestionHin,
  RelativeHin,
  ConjunctionHin,
  PhraseHin,
  TextX,
  StructuralHin,
  IdiomHin,
  TenseX
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}
