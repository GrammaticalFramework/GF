--# -path=.:../abstract:../common:../prelude:

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
  TextX - [Adv,AdN,SC],
  StructuralHin,
  TenseX - [Adv,AdN,SC],
  IdiomHin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


