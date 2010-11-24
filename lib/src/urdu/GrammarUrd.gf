--# -path=.:../abstract:../common:../prelude:c:/gf_unicoded/hindustani

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
  TextX - [Adv,AdN],
  StructuralUrd,
  TenseX - [Adv,AdN],
  IdiomUrd
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


