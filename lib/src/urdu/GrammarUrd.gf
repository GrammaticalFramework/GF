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
  TextUrd - [Adv,AdN,SC],
--  TextX - [Adv,AdN],
  StructuralUrd,
  TenseX - [Adv,AdN,SC],
  IdiomUrd
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


