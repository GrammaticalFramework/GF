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
  TextUrd - [Adv,AdN],
--  TextX - [Adv,AdN],
  StructuralUrd,
  TenseX - [Adv,AdN],
  IdiomUrd
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


