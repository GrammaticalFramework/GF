--# -path=.:../abstract:../common:../prelude

 concrete GrammarSnd of Grammar = 
   NounSnd, 
  VerbSnd, 
  AdjectiveSnd,
  AdverbSnd,
  NumeralSnd,
  SentenceSnd,
  QuestionSnd,
  RelativeSnd,
  ConjunctionSnd,
  PhraseSnd,
  TextX - [Adv],
  StructuralSnd,
  TenseX - [Adv],
  IdiomSnd
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


