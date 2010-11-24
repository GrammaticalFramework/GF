--# -path=.:../abstract:../common:../prelude:c:/gf_unicoded/hindustani

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
  TextX - [Adv,AdN],
  StructuralHin,
  TenseX - [Adv,AdN],
  IdiomHin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


